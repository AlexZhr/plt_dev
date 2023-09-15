
function my_array_uniq(param_1) {
    var array = [];
    
    param_1.forEach(element => {
        if (!array.includes(element)) {
            array.push(element);
        }
    });

    return array;
};
