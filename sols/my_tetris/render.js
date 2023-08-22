var canvas1 = document.getElementById("next-piece");
let context1 = canvas1.getContext("2d");

canvas1.width = 4 * scl;
canvas1.height = 4 * scl;

context1.scale(scl, scl);

const pieceField = createMatrix(4, 4);

function changePiece(ctx, player) {
    ctx.clearRect(0, 0, 4, 4);
    playerResetPosition(pieceField);
    draw(ctx, pieceField, player, canvas1, false);
    playerResetPosition(playField);
}

var canvas2 = document.getElementById("hold-piece");
let context2 = canvas2.getContext("2d");

canvas2.width = 4 * scl;
canvas2.height = 4 * scl;

context2.scale(scl, scl);

let holdAccess = true;

function holdTetrimino() {
    if (holdPlayer.matrix === null) {
        holdPlayer.matrix = player.matrix;
        playerReset();
        playerResetPosition(playField);
    } else if (holdAccess === true) {
        [holdPlayer.matrix, player.matrix] = [player.matrix, holdPlayer.matrix];
        holdAccess = false;
        playerResetPosition(playField);
    }
    draw(context2, pieceField, holdPlayer, canvas2, false);
}

// render text that describe current game status
function renderGameStatus() {
    if (gameStatus.gameOver === true) {
        drawGameStatus("GAME OVER", canvas.height / 2);
        drawGameStatus("PRESS ANY KEY", scl);
    } else if (gameStatus.start !== true) {
        drawGameStatus("PRESS ANY KEY", scl);
    } else if (gameStatus.start === true && gameStatus.dropPause === true) {
        drawGameStatus("PAUSE", scl);
        // } else if (gameStatus.start === true && gameStatus.run === false) {
        // countDown();
        // gameStatus.run = true;
    } else if (gameStatus.start === true && gameStatus.dropPause === false) {
        drawGameStatus(`${player.levelGoal} TO LVL ${player.level + 1}`, scl);
    } else if (gameStatus.gameOver === true) {
        drawGameStatus("GAME OVER", scl);
    }
}

function drawGameStatus(text, heightPostion) {
    ctx.fillStyle = "#718d70";
    ctx.fillRect(0, 0, canvas.width, 1.97);
    ctx.scale(1 / scl, 1 / scl);
    // ctx.clearRect(0, 0, canvas.width, canvas.height); // Clear the canvas before rendering
    ctx.save();
    ctx.strokeStyle = "hsl(279,13,20)";
    // ctx.lineTo(canvas.width / 2, canvas.height / 2);
    ctx.lineWidth = 2;
    ctx.fillStyle = "#f28444";
    ctx.textAlign = "center";
    ctx.textBaseline = "middle";
    ctx.font = "italic bold 48px sans-serif";
    ctx.fillText(text, canvas.width / 2, heightPostion, canvas.width);
    ctx.strokeText(text, canvas.width / 2, heightPostion, canvas.width);
    ctx.restore();
    ctx.scale(scl, scl);
}

function countDown() {
    let i = 3;
    const intervalId = setInterval(() => {
        if (i === -1) {
            clearInterval(intervalId);
            // setTimeout(() => {
            gameStatus.run = true;
            // }, 1000);
        } else if (i > 0) {
            drawGameStatus(`START IN ${i}`, scl);
        } else {
            drawGameStatus("GOOD LUCK =)", scl);
        }
        i--;
    }, 1000);
}

function gameOver() {
    for (let key in gameStatus) {
        if (key !== "playMusic") gameStatus[key] = false;
    }
    gameStatus.gameOver = true;
    musicTheme.pause();
}

const newGame = function pressKeyToPlay() {
    player.matrix = [
        [0, 0],
        [0, 0],
    ];
    if (gameStatus.gameOver === true) {
        gameStatus.gameOver = false;
        player.level = 1;
        player.bToB = 1;
        player.score = 0;
        player.levelGoal = 3000;
        player.fRowClean = 0;
    }
    playField.forEach((row) => row.fill(0));
    draw(context1, pieceField, player, canvas1, false);
    draw(context2, pieceField, player, canvas1, false);
    ctx.clearRect(0, 0, playField[0].length, playField.length);
    draw(ctx, playField, player, canvas, true);
    updateLevel();
    updateScore();
};
