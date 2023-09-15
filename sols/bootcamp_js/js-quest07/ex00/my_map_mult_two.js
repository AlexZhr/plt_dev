function my_map_mult_two(param_1) {
    var array = [];
    
    param_1.forEach(element => {
        array.push(element * 2);
    });

    return array;
};
