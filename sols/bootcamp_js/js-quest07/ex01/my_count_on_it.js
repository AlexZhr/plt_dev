function my_count_on_it(param_1) {
    var array = [];
    param_1.forEach(element => {
        array.push(element.length);
    });

    return array; 
};
