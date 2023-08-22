let scl = (window.innerHeight - 50) / 22;

var canvas;
let ctx;

function startGame() {
    console.log("starting game...");
    countDown();
    setTimeout(() => {
        soundEffect(soundCountdown);
        soundEffect(musicTheme);
    }, 1000);

    // renderGameStatus();
    setTimeout(() => {
        // ctx.scale(scl, scl);
        updateTetriminos(pieceField);
        draw(context1, pieceField, nextPlayer, canvas1, false);
        updateTetriminos(playField);
        gameStatus.start = true;
        // updateLevel();
        // updateScore();
        draw(ctx, playField, player, canvas, true);
        update();
    }, 5000);
}

function runGame() {
    canvas = document.getElementById("tetris");

    canvas.width = 10 * scl; /*window.innerWidth;*/
    canvas.height = 22 * scl;

    ctx = canvas.getContext("2d");
    ctx.scale(scl, scl);

    newGame();
}

function startGameWithModal() {
    const backdrop = document.querySelector(".backdrop");
    const btnStart = document.querySelector(".btn-start");
    const tetrisGame = document.querySelector(".tetris-container");
    const cuts = document.querySelector(".cuts");

    btnStart.addEventListener("click", () => {
        backdrop.classList.add("is-hidden");

        setTimeout(() => {
            backdrop.style.display = "none";
            tetrisGame.style.display = "flex";
            cuts.style.display = "block";
            gameStatus.backdrop = false;
            runGame();
        }, 250);
    });
}

document.addEventListener("DOMContentLoaded", startGameWithModal);

function playFieldSweep() {
    let combo = true;
    let rowCount = 0;
    let pCleanlScore = 0;

    outer: for (let y = playField.length - 1; y > 0; --y) {
        for (let x = 0; x < playField[y].length; ++x) {
            if (playField[y][x] === 0) {
                if (y === playField.length - 1 && rowCount === 0) {
                    player.fRowClean = 0;
                    player.bToB = 1;
                    // console.log("first row isn`t filled");
                }
                continue outer;
            }
        }
        const row = playField.splice(y, 1)[0].fill(0);
        playField.unshift(row);
        ++y;

        if (y === playField.length && combo === true) {
            combo = false;
            player.fRowClean += 1;
        }
        rowCount += 1;
    }

    // console.log(`first row score is: ${player.fRowClean}`);

    let sum = playField[playField.length - 1].reduce((a, b) => {
        return a + b;
    });

    if (player.fRowClean > 1) {
        player.bToB = 1.5;
    }

    if (sum === 0) {
        console.log("Perfect clean");
        pCleanlScore = 700;
    }

    if (combo === false) {
        switch (rowCount) {
            case 1:
                player.score +=
                    (100 + pCleanlScore) * player.level * player.bToB;
                break;
            case 2:
                player.score +=
                    (300 + Math.ceil(pCleanlScore * 1.2857)) *
                    player.level *
                    player.bToB;
                break;
            case 3:
                player.score +=
                    (500 + Math.ceil(pCleanlScore * 1.857)) *
                    player.level *
                    player.bToB;
                break;
            case 4:
                player.score +=
                    (800 + Math.ceil(pCleanlScore * 3.4285)) *
                    player.level *
                    player.bToB;
                break;
        }
    } else {
        player.score += 50 * rowCount * player.level;
    }

    if (rowCount === 4) {
        soundEffect(soundTetris);
    } else if (rowCount > 0 && rowCount <= 3) {
        soundEffect(soundLineClear);
    }

    if (player.score > player.levelGoal) {
        player.level += 1;
        player.levelGoal *= 2;
        soundEffect(soundLevelUp);
    }

    updateLevel();
}

function collide(playField, player) {
    const [m, o] = [player.matrix, player.pos];
    for (let y = 0; y < m.length; ++y) {
        for (let x = 0; x < m[y].length; ++x) {
            if (
                m[y][x] !== 0 &&
                (playField[y + o.y] && playField[y + o.y][x + o.x]) !== 0
            ) {
                return true;
            }
        }
    }
    return false;
}

function createPiece(type) {
    switch (type) {
        case "T":
            return [
                [0, 1, 0],
                [1, 1, 1],
                [0, 0, 0],
            ];
        case "O":
            return [
                [2, 2],
                [2, 2],
            ];
        case "L":
            return [
                [0, 3, 0],
                [0, 3, 0],
                [0, 3, 3],
            ];
        case "J":
            return [
                [0, 4, 0],
                [0, 4, 0],
                [4, 4, 0],
            ];
        case "I":
            return [
                [0, 5, 0, 0],
                [0, 5, 0, 0],
                [0, 5, 0, 0],
                [0, 5, 0, 0],
            ];
        case "S":
            return [
                [0, 6, 6],
                [6, 6, 0],
                [0, 0, 0],
            ];
        case "Z":
            return [
                [7, 7, 0],
                [0, 7, 7],
                [0, 0, 0],
            ];
    }
}

function createMatrix(w, h) {
    const matrix = [];
    while (h--) {
        matrix.push(new Array(w).fill(0));
    }
    return matrix;
}

function draw(ctx, field, piece, canvas, header) {
    ctx.fillStyle = "#718d70";
    ctx.fillRect(0, 0, canvas.width, canvas.height);

    drawMatrix(field, { x: 0, y: 0 }, ctx, header);
    drawMatrix(piece.matrix, piece.pos, ctx, header);
}

function drawMatrix(matrix, offset, ctx, header) {
    matrix.forEach((row, y) => {
        row.forEach((value, x) => {
            if (value !== 0) {
                ctx.fillStyle = colors[value];
                ctx.fillRect(
                    x + offset.x + 0.075,
                    y + offset.y + 0.075,
                    0.85,
                    0.85
                );
                ctx.strokeRect(
                    x + offset.x + 0.075,
                    y + offset.y + 0.075,
                    0.85,
                    0.85
                );
            }
            ctx.beginPath();
            ctx.strokeStyle = "black";
            ctx.lineWidth = 0.01;
            ctx.strokeRect(x + offset.x, y + offset.y, 1, 1);
        });
    });
    if (header === true) {
        renderGameStatus();
    }
}

function playerDrop() {
    player.pos.y++;
    if (collide(playField, player)) {
        player.pos.y--;
        merge(playField, player);
        updateTetriminos(playField);
        changePiece(context1, nextPlayer);
        playFieldSweep();
        updateScore();
        holdAccess = true;
        soundEffect(soundPieceLanding);
    } else {
        soundEffect(soundMove);
    }
    dropCounter = 0;
}

function playerHardDrop() {
    while (!collide(playField, player)) {
        player.pos.y++;
        player.score += 2;
    }
    player.pos.y--;
    player.score--;
    merge(playField, player);
    updateTetriminos(playField);
    changePiece(context1, nextPlayer);
    playFieldSweep();
    updateScore();
    dropCounter = 0;
    holdAccess = true;
    soundEffect(soundHardDrop);
}

function playerMove(dir) {
    player.pos.x += dir;
    if (collide(playField, player)) {
        player.pos.x -= dir;
    } else {
        soundEffect(soundMove);
    }
}

const tetriminos = new Tetriminos();

function updateTetriminos(matrix) {
    if (gameStatus.start === false || collide(playField, player)) {
        playerReset();
        playerResetPosition(matrix);
    } else {
        playerResetPosition(matrix);
    }
}

function playerReset() {
    // const tetrimino = tetriminos.getTetriminoFromBag();
    if (gameStatus.start === false) {
        player.matrix = createPiece(tetriminos.getTetriminoFromBag());
    } else {
        player.matrix = nextPlayer.matrix;
    }
    nextPlayer.matrix = createPiece(tetriminos.getTetriminoFromBag());
}

function playerResetPosition(matrix) {
    player.pos.y = 0;
    player.pos.x =
        ((matrix[0].length / 2) | 0) - ((player.matrix[0].length / 2) | 0);
    if (collide(matrix, player)) {
        soundEffect(soundGameOver);
        gameOver();
        updateLevel();
        updateScore();
    }
}
document.addEventListener("keydown", (event) => {
    if (!event.code.startsWith("F") && gameStatus.backdrop === true) {
        event.preventDefault();
    } else if (!event.code.startsWith("F")) {
        event.preventDefault();
        if (gameStatus.start === true && gameStatus.run === true) {
            if (
                gameStatus.dropPause === false &&
                gameStatus.gameOver === false
            ) {
                if (["p", "P", "Escape"].includes(event.key)) {
                    gameStatus.dropPause = !gameStatus.dropPause;
                } else if (event.key === "ArrowLeft") {
                    playerMove(-1);
                } else if (event.key === "ArrowRight") {
                    playerMove(1);
                } else if (event.key === "ArrowDown") {
                    playerDrop();
                    player.score += 1;
                } else if (["ArrowUp", "x", "X"].includes(event.key)) {
                    playerRotate(1);
                } else if (["Control", "z", "Z"].includes(event.key)) {
                    playerRotate(-1);
                } else if (event.key === " ") {
                    playerHardDrop();
                } else if (
                    event.key === "Shift" ||
                    event.key.toLowerCase() === "c"
                ) {
                    holdTetrimino();
                }
            } else if (["p", "P", "Escape"].includes(event.key)) {
                gameStatus.dropPause = !gameStatus.dropPause;
            }
            updateScore();
        } else if (
            gameStatus.gameOver === false &&
            gameStatus.countDown === false
        ) {
            gameStatus.countDown = true;
            startGame();
        } else if (gameStatus.gameOver === true) {
            runGame();
        }
    }
});

function gameController() {
    btnClick = document.querySelectorAll(".btn");

    let pause = false;
    let left = false;
    let right = false;
    let down = false;
    let rotateByClick = false;
    let hDropByClick = false;
    let holdByClick = false;

    for (let i = 0; i < btnClick.length; i++) {
        btnClick[i].addEventListener("mousedown", (event) => {
            switch (event.target.id) {
                case "start-pause":
                    if (
                        gameStatus.start === false &&
                        gameStatus.gameOver === false &&
                        gameStatus.countDown === false
                    ) {
                        gameStatus.countDown = true;
                        startGame();
                    } else if (gameStatus.gameOver === true) {
                        runGame();
                    } else {
                        pause = true;
                    }
                    break;
                case "togglesound":
                    if (gameStatus.playMusic === true) {
                        musicTheme.pause();
                        gameStatus.playMusic = false;
                    } else {
                        musicTheme.play();
                        gameStatus.playMusic = true;
                    }
                    break;
                case "game-reset":
                    gameOver();
                    update();
                    runGame();
                    break;
                case "btn-left":
                    left = true;
                    break;
                case "btn-right":
                    right = true;
                    break;
                case "btn-down":
                    down = true;
                    break;
                case "btn-rotate":
                    rotateByClick = true;
                    break;
                case "btn-hDrop":
                    hDropByClick = true;
                    break;
                case "btn-hold":
                    // holdByClick = true;
                    holdTetrimino();
                    break;
            }

            // console.log(gameStatus.dropPause);

            if (
                gameStatus.dropPause === false &&
                gameStatus.gameOver === false
            ) {
                if (pause === true) {
                    gameStatus.dropPause = !gameStatus.dropPause;
                } else if (left === true) {
                    if (gameStatus.start === false) {
                        if (player.level < 15) {
                            player.level += 1;
                            player.levelGoal *= 2;
                        } else {
                            player.level = 1;
                            player.levelGoal = 3000;
                        }
                        updateLevel();
                    } else {
                        playerMove(-1);
                    }
                } else if (right === true) {
                    playerMove(1);
                } else if (down === true) {
                    playerDrop();
                } else if (rotateByClick === true) {
                    playerRotate(1);
                } else if (hDropByClick === true) {
                    playerHardDrop();
                }
            } else if (pause === true) {
                gameStatus.dropPause = !gameStatus.dropPause;
            }
            if (gameStatus.countDown === false) {
                soundEffect(soundMenu);
            }
        });

        btnClick[i].addEventListener("mouseup", () => {
            pause = false;
            left = false;
            right = false;
            down = false;
            rotateByClick = false;
            hDropByClick = false;
        });
    }
}

document.addEventListener("DOMContentLoaded", gameController);
function playerRotate(dir) {
    const pos = player.pos.x;
    let offset = 1;
    rotate(player.matrix, dir);
    // for (let y = 0; y < player.matrix.length; y += player[0].length) {
    while (collide(playField, player)) {
        player.pos.x += offset;
        offset = -(offset + (offset > 0 ? 1 : -1));
        if (offset > player.matrix[0].length) {
            rotate(player.matrix, -dir);
            player.pos.x = pos;
            return;
        }
    }
    soundEffect(soundRotate);
}

function rotate(matrix, dir) {
    for (let y = 0; y < matrix.length; y++) {
        for (let x = 0; x < y; x++) {
            [matrix[x][y], matrix[y][x]] = [matrix[y][x], matrix[x][y]];
        }
    }
    if (dir > 0) {
        matrix.forEach((row) => row.reverse());
    } else {
        matrix.reverse();
    }
}

let dropCounter = 0;
let dropInterval = 1000;
let lastTime = 0;

function update(time = 0) {
    const deltaTime = time - lastTime;
    lastTime = time;

    dropCounter += deltaTime;

    if (
        dropCounter > dropInterval &&
        gameStatus.dropPause === false &&
        gameStatus.start === true &&
        gameStatus.run === true &&
        gameStatus.gameOver === false
    ) {
        playerDrop();
    }

    renderGameStatus();

    draw(ctx, playField, player, canvas, true);
    if (gameStatus.start === false) {
        return;
    }
    requestAnimationFrame(update);
}

function tetriminoGravity() {
    dropInterval =
        (0.8 - (player.level - 1) * 0.007) ** (player.level - 1) * 1000;
}

const gameStatus = {
    backdrop: true,
    start: false,
    run: false,
    dropPause: false,
    gameOver: false,
    playMusic: true,
    countDown: false,
};

function updateScore() {
    let div = document.getElementById("score");
    div.innerText = player.score;
}

function updateLevel() {
    let div = document.getElementById("lvl");
    div.innerText = player.level;
    dropInterval = (0.8 - (player.level - 1) * 0.007) ** (player.level - 1);
    dropInterval *= 1000;
}

const colors = [
    null,
    "purple",
    "yellow",
    "orange",
    "blue",
    "cyan",
    "green",
    "red",
];

const playField = createMatrix(10, 22);

let player = {
    pos: { x: 0, y: 0 },
    matrix: [
        [0, 0],
        [0, 0],
    ],
    score: 0,
    level: 1,
    levelGoal: 3000,
    fRowClean: 0,
    bToB: 1,
};

const defaultPlayer = player;

const nextPlayer = {
    pos: { x: 0, y: 0 },
    matrix: null,
    score: 0,
};

const holdPlayer = {
    pos: { x: 0, y: 0 },
    matrix: null,
    score: 0,
};

function merge(playField, player) {
    player.matrix.forEach((row, y) => {
        row.forEach((value, x) => {
            if (value !== 0) {
                playField[y + player.pos.y][x + player.pos.x] = value;
            }
        });
    });
}

var musicTheme = loadMusic("./music/korobeiniki.mp3");
var soundTetris = loadMusic("./music/tetris-gb-22-tetris-4-lines.mp3");
var soundCountdown = loadMusic("./music/game-countdown.mp3");
var soundMove = loadMusic("./music/tetris-gb-18-move-piece.mp3");
var soundRotate = loadMusic("./music/tetris-gb-19-rotate-piece.mp3");
var soundMenu = loadMusic("./music/tetris-gb-17-menu-sound.mp3");
var soundLineClear = loadMusic("./music/tetris-gb-21-line-clear.mp3");
var soundGameOver = loadMusic("./music/tetris-gb-25-game-over.mp3");
var soundLevelUp = loadMusic("./music/tetris-gb-23-level-up-jingle-v1.mp3");
var soundPieceLanding = loadMusic("./music/tetris-gb-27-piece-landed.mp3");
var soundHardDrop = loadMusic("./music/tetris-shot.mp3");

function loadMusic(path) {
    return new Audio(path);
}

function soundEffect(sound) {
    if (gameStatus.playMusic === true) {
        sound.currentTime = 0;
        sound.play();
    } else {
        return;
    }
}
