"use strict";

window.Qy = (function() {
    var comparisons = {
        "lt": function(b, a) {
            return a < b;
        }, // less than
        "lte": function(b, a) {
            return a <= b;
        },
        "gt": function(b, a) {
            return a > b;
        }, // greater than
        "gte": function(b, a) {
            return a >= b;
        },
        "eq": function(b, a) {
            return a === b;
        },
        "not": function(b, a) {
            return b !== a;
        },
        "iexact": function(b, a) {
            return b.toLowerCase() === a.toLowerCase();
        },
        "icontain": function(b, a) {
            return a.toLowerCase().indexOf(b.toLowerCase()) > -1;
        },
        "contain": function(b, a) {
            return a.indexOf(b) > -1;
        },
        "in": function(b, a) {
            return b.indexOf(a) > -1;
        },
        "irgx": function(b, a) {
            return a.toLowerCase().match(b);
        },
        "rgx": function(b, a) {
                return a.match(b);
        } // if regex match any
    };

    function depth_property(levels, obj) {
        return levels.reduce(function(a, b) {
            return typeof a[b] === "function" ? a[b]() : a[b];
        }, obj);
    }

    function parse(query, value) {
        var queries = query.split("__"),
            props = queries.filter(function(a) {
                return !(a in comparisons)
            }),
            compare = queries
	            .filter(function(a) {
	                return a in comparisons;
	            })
	            .map(function(a) {
	                return comparisons[a].bind(void 0, value);
	            });

        return function(obj) {
            var obj_prop = depth_property(props, obj);
            if(typeof obj_prop === "function") 
            	obj_prop = obj_prop.bind(obj)();

            return compare.every(function(f) {
                return f(obj_prop);
            });
        }
    }

    return function(query_obj) {
        var funcs = Object.keys(query_obj).map(function(k) {
            return parse(k, query_obj[k]);
        });

        return function(obj) {
            return funcs.every(function(f) {
                return f(obj);
            });
        };
    };

})();