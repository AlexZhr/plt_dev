
function my_average_mark(param_1) {
    var mark = 0;
    
    param_1.forEach(element => {
        mark = mark + element.integer;
    });
    
    return param_1.length > 0 ? (mark / param_1.length).toFixed(1) : 0;
};
