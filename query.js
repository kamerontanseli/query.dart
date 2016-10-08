(function(root, factory) {
    if (typeof define === "function" && define.amd) {
        define(["postal"], function(postal) {
            return (root.Qy = factory(postal));
        });
    } else if (typeof module === "object" && module.exports) {
        module.exports = (root.Qy = factory(require("postal")));
    } else {
        root.Qy = factory(root.postal);
    }
}(this, function(postal) {

    var query_parser = function(query, value) {
        var query_comparisons = {
            "lt": function(b, a) {
                return a < b;
            }, // less than
            "gt": function(b, a) {
                return a > b;
            }, // greater than
            "eq": function(b, a) {
                return a === b;
            },
            "not": function(b, a) {
                return b !== a;
            },
            "contain": function(b, a) {
                return a.indexOf(b) > -1;
            },
            "rgx": function(b, a) {
                    return a.match(b);
                } // if regex match any
        };

        var queries = query.split("__"), // id__gt ---> id, gt
            partial_funcs = query_comparisons[queries[1]].bind(void 0, value);
        // set the first param to value and return function


        return function(obj) {
            return partial_funcs(obj[queries[0]]); // id__gt --> gt(obj[id])
        };
    };

    var query_chainer = function(query) {
        var comparison = Object.keys(query) // id__lt: 2
            .map(function(k) {
                return query_parser(k, query[k]); // lt(id)(obj)
            });
        return function(obj) {
            return comparison.every(function(f) {
                return f(obj);
            });
        };
    };

    return query_chainer;

}));