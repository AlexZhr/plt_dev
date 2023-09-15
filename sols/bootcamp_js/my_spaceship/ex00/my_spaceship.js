function my_spaceship(pos_ch) {
    
    var x = 0;
    var y = 0;
    var moveStr = "";
    var drc = "up";
    
    for(var i=0; i<pos_ch.length; i++){
        if (pos_ch[i] == 'A'){
            if (drc == "up") {
                y--;
            }
            else if (drc == "down") {
                y++;
            }
            else if (drc == "left") {
                x--;
            }
            else if (drc == "right") {
                x++;
            }
        }
        if (pos_ch[i] == 'R'){
            if (drc == "up") {
                drc = "right";
            }
            else if (drc == "right") {
                drc = "down";
            }
            else if (drc == "down") {
                drc = "left";
            }
            else if (drc == "left") {
                drc = "up";
            }
        }
        if (pos_ch[i] == 'L'){
            if (drc == "up") {
                drc = "left";
            }
            else if (drc == "left") {
                drc = "down";
            }
            else if (drc == "down") {
                drc = "right";
            }
            else if (drc == "right") {
                drc = "up";
            }
        }
    }
    
    //x: 2, y: -1, direction: 'down'
    moveStr = '{'+ "x: "+x+", y: "+y+", direction: '"+drc+"'"+'}';
    return moveStr;
}
my_spaceship("RAALALL")