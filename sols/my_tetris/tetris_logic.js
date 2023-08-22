class Tetriminos {
    constructor() {
        this.pieces = "IOTSZJL";
        this.bag = this.pieces;
        this.tetrimino = "";
    }

    bagOfSeven(tetrimino) {
        if (this.bag.length === 1) {
            return this.pieces;
        } else {
            let updatedBag = this.bag.replace(tetrimino, "");
            return updatedBag;
        }
    }

    getTetriminoFromBag() {
        let tetrimino = this.bag[(this.bag.length * Math.random()) | 0];
        this.bag = this.bagOfSeven(tetrimino);
        return tetrimino;
    }
}
