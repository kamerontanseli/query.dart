window.Ag = (function() {

	function depth_property(levels, obj) {
        return levels.reduce(function(a, b) {
            return typeof a[b] === "function" ? a[b]() : a[b];
        }, obj);
    }

    function get_prop(exp) {
    	return depth_property.bind(depth_property, exp.split("__"));
    }

	return {
		sum: function(exp, arr) {
			return arr.map(get_prop(exp)).reduce(function(a, b){
				return a + b;
			}, 0);
		},
		count: function(exp, arr)  {
			return arr.filter(get_prop(exp)).length;
		},
		avg: function(exp, arr) {
			var sum = this.sum(exp, arr);
			return sum / arr.length;
		},
		max: function(exp, arr) {
			var get = get_prop(exp);
			return Math.max.apply(Math.max, arr.filter(get).map(get));
		},
		min: function(exp, arr) {
			var get = get_prop(exp);
			return Math.min.apply(Math.min, arr.filter(get).map(get));
		}
	};

})();