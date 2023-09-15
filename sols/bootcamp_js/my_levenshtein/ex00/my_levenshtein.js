function my_levenshtein(s1, s2) {
    
    const notMutch = -1;
    var Vl = 0;

    if (s1.length != s2.length) {
        return notMutch;
    } else {
        for (let i=0; i <= s1.length; i++){
            Vl += s1[i] != s2[i];             
        }
    }
    return Vl;
}

