//! Responsible for the code generation stage of the Catspeak compiler.
//!
//! This stage converts Catspeak IR, produced by `CatspeakParser` or
//! `CatspeakIRBuilder`, into various lower-level formats. The most
//! interesting of these formats is the conversion of Catspeak programs into
//! native GML functions.

//# feather use syntax-errors
function GMLspeakGMLCompiler(ir, interface=undefined) constructor {
    if (CATSPEAK_DEBUG_MODE) {
        __catspeak_check_init();
        __catspeak_check_arg_struct("ir", ir,
            "functions", is_array,
            "entryPoints", is_array
        );
    }
    /// @ignore
    self.interface = interface;
    /// @ignore
    self.functions = ir.functions;
    /// @ignore
    self.sharedData = {
        globals : { },
        self_ : undefined,
    };
    //# feather disable once GM2043
    /// @ignore
    self.program = __compileFunctions(ir.entryPoints);
    /// @ignore
    self.finalised = false;

    /// @ignore
    ///
    /// @param {String} name
    /// @return {Any}
    static __get = function (name) {
        if (__catspeak_is_nullish(interface)) {
            return undefined;
        }
        return interface.get(name);
    }

    /// @ignore
    ///
    /// @param {String} name
    /// @return {Any}
    static __exists = function (name) {
        if (__catspeak_is_nullish(interface)) {
            return undefined;
        }
        return interface.exists(name);
    }

    /// @ignore
    ///
    /// @param {String} name
    /// @return {Bool}
    static __isDynamicConstant = function (name) {
        if (__catspeak_is_nullish(interface)) {
            return false;
        }
        return interface.isDynamicConstant(name);
    }

    /// Generates the code for a single term from the supplied Catspeak IR.
    ///
    /// @example
    ///   Creates a new `CatspeakGMLCompiler` from the variable `ir` and
    ///   loops until the compiler is finished compiling. The final result is
    ///   assigned to the `result` local variable.
    ///
    ///   ```gml
    ///   var compiler = new CatspeakGMLCompiler(ir);
    ///   var result;
    ///   do {
    ///       result = compiler.update();
    ///   } until (result != undefined);
    ///   ```
    ///
    /// @return {Function}
    ///   The final compiled Catspeak function if there are no more terms left
    ///   to compile, or `undefined` if there is still more left to compile.
    static update = function () {
        if (CATSPEAK_DEBUG_MODE && finalised) {
            __catspeak_error(
                "attempting to update gml compiler after it has been finalised"
            );
        }
        finalised = true;
        return program;
    };

    /// @ignore
    ///
    /// @param {Array} entryPoints
    /// @return {Function}
    static __compileFunctions = function (entryPoints) {
        var functions_ = functions;
        var entryCount = array_length(entryPoints);
        var exprs = array_create(entryCount);
        for (var i = 0; i < entryCount; i += 1) {
            var entry = entryPoints[i];
            if (CATSPEAK_DEBUG_MODE) {
                __catspeak_check_arg("entry", entry, is_numeric);
            }
            exprs[@ i] = __compileFunction(functions_[entry]);
        }
        var rootCall = __emitBlock(exprs);
        __setupCatspeakFunctionMethods(rootCall);
        return rootCall;
    };

    /// @ignore
    static __setupCatspeakFunctionMethods = function (f) {
        f.setSelf = method(sharedData, function (selfInst) {
            self_ = catspeak_special_to_struct(selfInst);
        });
        f.setGlobals = method(sharedData, function (globalInst) {
            globals = catspeak_special_to_struct(globalInst);
        });
        f.getSelf = method(sharedData, function () { return self_ ?? globals });
        f.getGlobals = method(sharedData, function () { return globals });
    };

    /// @ignore
    ///
    /// @param {Struct} func
    /// @return {Function}
    static __compileFunction = function (func) {
        if (CATSPEAK_DEBUG_MODE) {
            __catspeak_check_arg_struct("func", func,
                "localCount", is_numeric,
                "argCount", is_numeric,
                "root", undefined
            );
            __catspeak_check_arg_struct("func.root", func.root,
                "type", is_numeric
            );
        }
        var ctx = {
            callTime : -1,
            program : undefined,
            locals : array_create(func.localCount),
            argCount : func.argCount,
        };
        ctx.program = __compileTerm(ctx, func.root);
        if (__catspeak_term_is_pure(func.root.type)) {
            // if there's absolutely no way this function could misbehave,
            // use the fast path
            return ctx.program;
        }
        //return method(ctx, __catspeak_function__);
		return method({program:  method(ctx, __catspeak_function__), args: [], global_: undefined}, __gmlspeak_program__);
    };

    /// @ignore
    ///
    /// @param {Struct} ctx
    /// @param {Struct} term
    /// @return {Function}
    static __compileValue = function (ctx, term) {
        if (CATSPEAK_DEBUG_MODE) {
            __catspeak_check_arg_struct("term", term,
                "value", undefined
            );
        }
        return method({ value : term.value }, __catspeak_expr_value__);
    };

    /// @ignore
    ///
    /// @param {Struct} ctx
    /// @param {Struct} term
    /// @return {Function}
    static __compileArray = function (ctx, term) {
        if (CATSPEAK_DEBUG_MODE) {
            __catspeak_check_arg_struct("term", term,
                "values", is_array
            );
        }
        var values = term.values;
        var valueCount = array_length(values);
        var exprs = array_create(valueCount);
        for (var i = 0; i < valueCount; i += 1) {
            exprs[@ i] = __compileTerm(ctx, values[i]);
        }
        return method({
            values : exprs,
            n : array_length(exprs),
        }, __catspeak_expr_array__);
    };

    /// @ignore
    ///
    /// @param {Struct} ctx
    /// @param {Struct} term
    /// @return {Function}
    static __compileStruct = function (ctx, term) {
        if (CATSPEAK_DEBUG_MODE) {
            __catspeak_check_arg_struct("term", term,
                "values", is_array
            );
        }
        var values = term.values;
        var valueCount = array_length(values);
        var exprs = array_create(valueCount);
        for (var i = 0; i < valueCount; i += 1) {
            exprs[@ i] = __compileTerm(ctx, values[i]);
        }
        return method({
            values : exprs,
            n : array_length(exprs) div 2,
        }, __catspeak_expr_struct__);
    };

    /// @ignore
    ///
    /// @param {Struct} ctx
    /// @param {Struct} term
    /// @return {Function}
    static __compileBlock = function (ctx, term) {
        if (CATSPEAK_DEBUG_MODE) {
            __catspeak_check_arg_struct("term", term,
                "terms", is_array
            );
        }
        var terms = term.terms;
        var termCount = array_length(terms);
        var exprs = array_create(termCount);
        for (var i = 0; i < termCount; i += 1) {
            exprs[@ i] = __compileTerm(ctx, terms[i]);
        }
        return __emitBlock(exprs);
    };

    /// @ignore
    ///
    /// @param {Array} exprs
    /// @return {Function}
    static __emitBlock = function (exprs) {
        var exprCount = array_length(exprs);
        // hard-code some common block sizes
        if (exprCount == 1) {
            return exprs[0];
        } else if (exprCount == 2) {
            return method({
                _1st : exprs[0],
                _2nd : exprs[1],
            }, __catspeak_expr_block_2__);
        } else if (exprCount == 3) {
            return method({
                _1st : exprs[0],
                _2nd : exprs[1],
                _3rd : exprs[2],
            }, __catspeak_expr_block_3__);
        } else if (exprCount == 4) {
            return method({
                _1st : exprs[0],
                _2nd : exprs[1],
                _3rd : exprs[2],
                _4th : exprs[3],
            }, __catspeak_expr_block_4__);
        } else if (exprCount == 5) {
            return method({
                _1st : exprs[0],
                _2nd : exprs[1],
                _3rd : exprs[2],
                _4th : exprs[3],
                _5th : exprs[4],
            }, __catspeak_expr_block_5__);
        }
        // arbitrary size block
        return method({
            stmts : exprs,
            n : exprCount - 1,
            result : exprs[exprCount - 1],
        }, __catspeak_expr_block__);
    };

    /// @ignore
    ///
    /// @param {Struct} ctx
    /// @param {Struct} term
    /// @return {Function}
    static __compileIf = function (ctx, term) {
        if (CATSPEAK_DEBUG_MODE) {
            __catspeak_check_arg_struct("term", term,
                "condition", undefined,
                "ifTrue", undefined,
                "ifFalse", undefined
            );
        }
        if (__catspeak_is_nullish(term.ifFalse)) {
            return method({
                condition : __compileTerm(ctx, term.condition),
                ifTrue : __compileTerm(ctx, term.ifTrue),
            }, __catspeak_expr_if__);
        } else {
            return method({
                condition : __compileTerm(ctx, term.condition),
                ifTrue : __compileTerm(ctx, term.ifTrue),
                ifFalse : __compileTerm(ctx, term.ifFalse),
            }, __catspeak_expr_if_else__);
        }
    };

    /// @ignore
    ///
    /// @param {Struct} ctx
    /// @param {Struct} term
    /// @return {Function}
    static __compileWhile = function (ctx, term) {
        if (CATSPEAK_DEBUG_MODE) {
            __catspeak_check_arg_struct("term", term,
                "condition", undefined,
                "body", undefined
            );
        }
        return method({
            ctx : ctx,
            condition : __compileTerm(ctx, term.condition),
            body : __compileTerm(ctx, term.body),
        }, __catspeak_expr_while__);
    };

    /// @ignore
    ///
    /// @param {Struct} ctx
    /// @param {Struct} term
    /// @return {Function}
    static __compileMatch = function(ctx, term) {
        var i = 0;
        var n = array_length(term.arms);
        repeat n {
            var pair = term.arms[i];
            var condition = __catspeak_is_nullish(pair[0])
                    ? undefined
                    : __compileTerm(ctx, pair[0]);
            term.arms[i] = {
                condition : condition,
                result : __compileTerm(ctx, pair[1]),
            };
            i += 1;
        }
        return method({
            value: __compileTerm(ctx, term.value),
            arms: term.arms,
        }, __catspeak_expr_match__);
    };

    /// @ignore
    ///
    /// @param {Struct} ctx
    /// @param {Struct} term
    /// @return {Function}
    static __compileUse = function (ctx, term) {
        if (CATSPEAK_DEBUG_MODE) {
            __catspeak_check_arg_struct("term", term,
                "condition", undefined,
                "body", undefined
            );
        }
        return method({
            dbgError : __dbgTerm(term.condition, "is not a function"),
            condition : __compileTerm(ctx, term.condition),
            body : __compileTerm(ctx, term.body),
        }, __catspeak_expr_use__);
    };

    /// @ignore
    ///
    /// @param {Struct} ctx
    /// @param {Struct} term
    /// @return {Function}
    static __compileReturn = function (ctx, term) {
        if (CATSPEAK_DEBUG_MODE) {
            __catspeak_check_arg_struct("term", term,
                "value", undefined
            );
        }
        return method({
            value : __compileTerm(ctx, term.value),
        }, __catspeak_expr_return__);
    };

    /// @ignore
    ///
    /// @param {Struct} ctx
    /// @param {Struct} term
    /// @return {Function}
    static __compileBreak = function (ctx, term) {
        if (CATSPEAK_DEBUG_MODE) {
            __catspeak_check_arg_struct("term", term,
                "value", undefined
            );
        }
        return method({
            value : __compileTerm(ctx, term.value),
        }, __catspeak_expr_break__);
    };

    /// @ignore
    ///
    /// @param {Struct} ctx
    /// @param {Struct} term
    /// @return {Function}
    static __compileContinue = function (ctx, term) {
        return method(undefined, __catspeak_expr_continue__);
    };

    /// @ignore
    ///
    /// @param {Struct} ctx
    /// @param {Struct} term
    /// @return {Function}
    static __compileOpUnary = function (ctx, term) {
        if (CATSPEAK_DEBUG_MODE) {
            __catspeak_check_arg_struct("term", term,
                "operator", is_numeric, // TODO :: add proper bounds check here
                "value", undefined
            );
        }
        return method({
            op : __catspeak_operator_get_unary(term.operator),
            value : __compileTerm(ctx, term.value),
        }, __catspeak_expr_op_1__);
    };

    /// @ignore
    ///
    /// @param {Struct} ctx
    /// @param {Struct} term
    /// @return {Function}
    static __compileOpBinary = function (ctx, term) {
        if (CATSPEAK_DEBUG_MODE) {
            __catspeak_check_arg_struct("term", term,
                "operator", is_numeric, // TODO :: add proper bounds check here
                "lhs", undefined,
                "rhs", undefined
            );
        }
        return method({
            op : __catspeak_operator_get_binary(term.operator),
            lhs : __compileTerm(ctx, term.lhs),
            rhs : __compileTerm(ctx, term.rhs),
        }, __catspeak_expr_op_2__);
    };

    /// @ignore
    ///
    /// @param {Struct} ctx
    /// @param {Struct} term
    /// @return {Function}
    static __compileAnd = function (ctx, term) {
        if (CATSPEAK_DEBUG_MODE) {
            __catspeak_check_arg_struct("term", term,
                "eager", undefined,
                "lazy", undefined
            );
        }
        return method({
            eager : __compileTerm(ctx, term.eager),
            lazy : __compileTerm(ctx, term.lazy),
        }, __catspeak_expr_and__);
    };

    /// @ignore
    ///
    /// @param {Struct} ctx
    /// @param {Struct} term
    /// @return {Function}
    static __compileOr = function (ctx, term) {
        if (CATSPEAK_DEBUG_MODE) {
            __catspeak_check_arg_struct("term", term,
                "eager", undefined,
                "lazy", undefined
            );
        }
        return method({
            eager : __compileTerm(ctx, term.eager),
            lazy : __compileTerm(ctx, term.lazy),
        }, __catspeak_expr_or__);
    };

    /// @ignore
    ///
    /// @param {Struct} ctx
    /// @param {Struct} term
    /// @return {Function}
    static __compileCall = function (ctx, term) {
        if (CATSPEAK_DEBUG_MODE) {
            __catspeak_check_arg_struct("term", term,
                "callee", undefined,
                "args", undefined
            );
            __catspeak_check_arg_struct("term.callee", term.callee,
                "type", is_numeric
            );
        }
        var args = term.args;
        var argCount = array_length(args);
        var exprs = array_create(argCount);
        for (var i = 0; i < argCount; i += 1) {
            exprs[@ i] = __compileTerm(ctx, args[i]);
        }
        if (term.callee.type == CatspeakTerm.INDEX) {
            if (CATSPEAK_DEBUG_MODE) {
                __catspeak_check_arg_struct("term.callee", term.callee,
                    "collection", undefined,
                    "key", undefined
                );
            }
            var collection = __compileTerm(ctx, term.callee.collection);
            var key = __compileTerm(ctx, term.callee.key);
            return method({
                dbgError : __dbgTerm(term.callee, "is not a function"),
                collection : collection,
                key : key,
                args : exprs,
                shared : sharedData,
            }, __catspeak_expr_call_method__);
        } else {
            var callee = __compileTerm(ctx, term.callee);
            return method({
                dbgError : __dbgTerm(term.callee, "is not a function"),
                callee : callee,
                args : exprs,
                shared : sharedData,
            }, __catspeak_expr_call__);
        }
    };

    /// @ignore
    ///
    /// @param {Struct} ctx
    /// @param {Struct} term
    /// @return {Function}
    static __compileCallNew = function (ctx, term) {
        // NOTE :: blehhh ugly code pls pls refactor fr fr ong no cap
        if (CATSPEAK_DEBUG_MODE) {
            __catspeak_check_arg_struct("term", term,
                "callee", undefined,
                "args", undefined
            );
            __catspeak_check_arg_struct("term.callee", term.callee,
                "type", is_numeric
            );
        }
        var args = term.args;
        var argCount = array_length(args);
        var exprs = array_create(argCount);
        for (var i = 0; i < argCount; i += 1) {
            exprs[@ i] = __compileTerm(ctx, args[i]);
        }
        var callee = __compileTerm(ctx, term.callee);
        return method({
            dbgError : __dbgTerm(term.callee, "is not constructible"),
            callee : callee,
            args : exprs,
        }, __catspeak_expr_call_new__);
    };

    /// @ignore
    ///
    /// @param {Struct} ctx
    /// @param {Struct} term
    /// @return {Function}
    static __compileSet = function (ctx, term) {
        if (CATSPEAK_DEBUG_MODE) {
            __catspeak_check_arg_struct("term", term,
                "assignType", is_numeric,
                "target", undefined,
                "value", undefined,
            );
            __catspeak_check_arg_struct("term.target", term.target,
                "type", is_numeric
            );
        }
        var target = term.target;
        var targetType = target.type;
        var value = __compileTerm(ctx, term.value);
        if (targetType == CatspeakTerm.INDEX) {
            if (CATSPEAK_DEBUG_MODE) {
                __catspeak_check_arg_struct("term.target", target,
                    "collection", undefined,
                    "key", undefined
                );
            }
            var func = __assignLookupIndex[term.assignType];
            return method({
                dbgError : __dbgTerm(target.collection, "is not indexable"),
                collection : __compileTerm(ctx, target.collection),
                key : __compileTerm(ctx, target.key),
                value : value,
            }, func);
        } else if (targetType == CatspeakTerm.PROPERTY) {
            if (CATSPEAK_DEBUG_MODE) {
                __catspeak_check_arg_struct("term.target", target,
                    "property", undefined
                );
            }
            var func = __assignLookupProperty[term.assignType];
            return method({
                dbgError : __dbgTerm(target.property, "is not a function"),
                property : __compileTerm(ctx, target.property),
                value : value,
            }, func);
        } else if (targetType == CatspeakTerm.LOCAL) {
            if (CATSPEAK_DEBUG_MODE) {
                __catspeak_check_arg_struct("term.target", target,
                    "idx", is_numeric
                );
            }
            var func = __assignLookupLocal[term.assignType];
            return method({
                locals : ctx.locals,
                idx : target.idx,
                value : value,
            }, func);
        } else if (targetType == CatspeakTerm.GLOBAL) {
            if (CATSPEAK_DEBUG_MODE) {
                __catspeak_check_arg_struct("term.target", target,
                    "name", is_string
                );
            }
            var name = target.name;
            if (__exists(name)) {
                // cannot assign to interface values
                __catspeak_error(
                    __catspeak_location_show(target.dbg),
                    " -- invalid assignment target, ",
                    "cannot assign to built-in function or constant"
                );
            }

            var func = __assignLookupGlobal[term.assignType];
            return method({
                shared : sharedData,
                name : name,
                value : value,
            }, func);
        } else {
            if (CATSPEAK_DEBUG_MODE) {
                __catspeak_check_arg_struct("term.target", target,
                    "dbg", undefined
                );
            }
            __catspeak_error(
                __catspeak_location_show(target.dbg),
                " -- invalid assignment target, ",
                "must be an identifier or accessor expression"
            );
        }
    };

    /// @ignore
    ///
    /// @param {Struct} ctx
    /// @param {Struct} term
    /// @return {Function}
    static __compileIndex = function (ctx, term) {
        if (CATSPEAK_DEBUG_MODE) {
            __catspeak_check_arg_struct("term", term,
                "collection", undefined,
                "key", undefined
            );
        }
        return method({
            dbgError : __dbgTerm(term.collection, "is not indexable"),
            collection : __compileTerm(ctx, term.collection),
            key : __compileTerm(ctx, term.key),
        }, __catspeak_expr_index_get__);
    };

    /// @ignore
    ///
    /// @param {Struct} ctx
    /// @param {Struct} term
    /// @return {Function}
    static __compileProperty = function (ctx, term) {
        if (CATSPEAK_DEBUG_MODE) {
            __catspeak_check_arg_struct("term", term,
                "property", undefined
            );
        }
        return method({
            dbgError : __dbgTerm(term.property, "is not a function"),
            property : __compileTerm(ctx, term.property),
        }, __catspeak_expr_property_get__);
    };

    /// @ignore
    ///
    /// @param {Struct} ctx
    /// @param {Struct} term
    /// @return {Function}
    static __compileGlobal = function (ctx, term) {
        if (CATSPEAK_DEBUG_MODE) {
            __catspeak_check_arg_struct("term", term,
                "name", is_string
            );
        }
        var name = term.name;
        if (__exists(name)) {
            var _callee = method({
                value : __get(name),
            }, __catspeak_expr_value__);
            if (__isDynamicConstant(name)) {
                // dynamic constant
                return method({
                    dbgError : __dbgTerm(term, "is not a function"),
                    callee : _callee,
                    args : [],
                    shared : sharedData,
                }, __catspeak_expr_call__);
            } else {
                // user-defined interface
                return _callee;
            }
        } else {
            // global var
            return method({
                name : name,
                shared : sharedData,
            }, __catspeak_expr_global_get__);
        }
    };

    /// @ignore
    ///
    /// @param {Struct} ctx
    /// @param {Struct} term
    /// @return {Function}
    static __compileLocal = function (ctx, term) {
        if (CATSPEAK_DEBUG_MODE) {
            __catspeak_check_arg_struct("term", term,
                "idx", is_numeric
            );
        }
        return method({
            locals : ctx.locals,
            idx : term.idx,
        }, __catspeak_expr_local_get__);
    };

    /// @ignore
    ///
    /// @param {Struct} ctx
    /// @param {Struct} term
    /// @return {Function}
    static __compileFunctionExpr = function (ctx, term) {
        if (CATSPEAK_DEBUG_MODE) {
            __catspeak_check_arg_struct("term", term,
                "idx", is_numeric
            );
        }
        var funcExpr = __compileFunction(functions[term.idx]);
        __setupCatspeakFunctionMethods(funcExpr);
        return method({
            value : funcExpr,
        }, __catspeak_expr_value__);
    };

    /// @ignore
    ///
    /// @param {Struct} ctx
    /// @param {Struct} term
    /// @return {Function}
    static __compileSelf = function (ctx, term) {
        return method(sharedData, __catspeak_expr_self__);
    };

    /// @ignore
    ///
    /// @param {Struct} ctx
    /// @param {Struct} term
    /// @return {Function}
    static __compileTerm = function (ctx, term) {
        if (CATSPEAK_DEBUG_MODE) {
            __catspeak_check_arg_struct("term", term,
                "type", is_numeric
            );
        }
        var prod = __productionLookup[term.type];
        if (CATSPEAK_DEBUG_MODE && __catspeak_is_nullish(prod)) {
            __catspeak_error_bug();
        }
        return prod(ctx, term);
    };

    /// @ignore
    static __productionLookup = (function () {
        var db = array_create(CatspeakTerm.__SIZE__, undefined);
        db[@ CatspeakTerm.VALUE] = __compileValue;
        db[@ CatspeakTerm.ARRAY] = __compileArray;
        db[@ CatspeakTerm.STRUCT] = __compileStruct;
        db[@ CatspeakTerm.BLOCK] = __compileBlock;
        db[@ CatspeakTerm.IF] = __compileIf;
        db[@ CatspeakTerm.WHILE] = __compileWhile;
        db[@ CatspeakTerm.MATCH] = __compileMatch;
        db[@ CatspeakTerm.USE] = __compileUse;
        db[@ CatspeakTerm.RETURN] = __compileReturn;
        db[@ CatspeakTerm.BREAK] = __compileBreak;
        db[@ CatspeakTerm.CONTINUE] = __compileContinue;
        db[@ CatspeakTerm.OP_BINARY] = __compileOpBinary;
        db[@ CatspeakTerm.OP_UNARY] = __compileOpUnary;
        db[@ CatspeakTerm.CALL] = __compileCall;
        db[@ CatspeakTerm.CALL_NEW] = __compileCallNew;
        db[@ CatspeakTerm.SET] = __compileSet;
        db[@ CatspeakTerm.INDEX] = __compileIndex;
        db[@ CatspeakTerm.PROPERTY] = __compileProperty;
        db[@ CatspeakTerm.GLOBAL] = __compileGlobal;
        db[@ CatspeakTerm.LOCAL] = __compileLocal;
        db[@ CatspeakTerm.FUNCTION] = __compileFunctionExpr;
        db[@ CatspeakTerm.SELF] = __compileSelf;
        db[@ CatspeakTerm.AND] = __compileAnd;
        db[@ CatspeakTerm.OR] = __compileOr;
        return db;
    })();

    /// @ignore
    static __assignLookupIndex = (function () {
        var db = array_create(CatspeakAssign.__SIZE__, undefined);
        db[@ CatspeakAssign.VANILLA] = __catspeak_expr_index_set__;
        db[@ CatspeakAssign.MULTIPLY] = __catspeak_expr_index_set_mult__;
        db[@ CatspeakAssign.DIVIDE] = __catspeak_expr_index_set_div__;
        db[@ CatspeakAssign.SUBTRACT] = __catspeak_expr_index_set_sub__;
        db[@ CatspeakAssign.PLUS] = __catspeak_expr_index_set_plus__;
        return db;
    })();

    /// @ignore
    static __assignLookupProperty = (function () {
        var db = array_create(CatspeakAssign.__SIZE__, undefined);
        db[@ CatspeakAssign.VANILLA] = __catspeak_expr_property_set__;
        db[@ CatspeakAssign.MULTIPLY] = __catspeak_expr_property_set_mult__;
        db[@ CatspeakAssign.DIVIDE] = __catspeak_expr_property_set_div__;
        db[@ CatspeakAssign.SUBTRACT] = __catspeak_expr_property_set_sub__;
        db[@ CatspeakAssign.PLUS] = __catspeak_expr_property_set_plus__;
        return db;
    })();

    /// @ignore
    static __assignLookupLocal = (function () {
        var db = array_create(CatspeakAssign.__SIZE__, undefined);
        db[@ CatspeakAssign.VANILLA] = __catspeak_expr_local_set__;
        db[@ CatspeakAssign.MULTIPLY] = __catspeak_expr_local_set_mult__;
        db[@ CatspeakAssign.DIVIDE] = __catspeak_expr_local_set_div__;
        db[@ CatspeakAssign.SUBTRACT] = __catspeak_expr_local_set_sub__;
        db[@ CatspeakAssign.PLUS] = __catspeak_expr_local_set_plus__;
        return db;
    })();

    /// @ignore
    static __assignLookupGlobal = (function () {
        var db = array_create(CatspeakAssign.__SIZE__, undefined);
        db[@ CatspeakAssign.VANILLA] = __catspeak_expr_global_set__;
        db[@ CatspeakAssign.MULTIPLY] = __catspeak_expr_global_set_mult__;
        db[@ CatspeakAssign.DIVIDE] = __catspeak_expr_global_set_div__;
        db[@ CatspeakAssign.SUBTRACT] = __catspeak_expr_global_set_sub__;
        db[@ CatspeakAssign.PLUS] = __catspeak_expr_global_set_plus__;
        return db;
    })();

    /// @ignore
    static __dbgTerm = function (term, msg="is invalid in this context") {
        if (CATSPEAK_DEBUG_MODE) {
            __catspeak_check_arg_struct("term", term,
                "dbg", undefined
            );
        }
        var terminalName = __catspeak_term_get_terminal(term);
        return "runtime error " + __catspeak_location_show_ext(term.dbg,
            __catspeak_is_nullish(terminalName)
                    ? "value"
                    : "variable '" + terminalName + "'",
            " ", msg
        );
    };
}