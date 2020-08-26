var __extends = (this && this.__extends) || (function () {
    var extendStatics = function (d, b) {
        extendStatics = Object.setPrototypeOf ||
            ({ __proto__: [] } instanceof Array && function (d, b) { d.__proto__ = b; }) ||
            function (d, b) { for (var p in b) if (b.hasOwnProperty(p)) d[p] = b[p]; };
        return extendStatics(d, b);
    };
    return function (d, b) {
        extendStatics(d, b);
        function __() { this.constructor = d; }
        d.prototype = b === null ? Object.create(b) : (__.prototype = b.prototype, new __());
    };
})();
var Animal = /** @class */ (function () {
    function Animal(type) {
        this.vel = 5;
        this.name = "Any";
        this.type = type;
    }
    Animal.prototype.info = function () {
        return {
            name: this.name,
            vel: this.vel,
            type: this.type
        };
    };
    return Animal;
}());
var Snake = /** @class */ (function (_super) {
    __extends(Snake, _super);
    function Snake() {
        var _this = _super !== null && _super.apply(this, arguments) || this;
        _this.vel = 10;
        _this.name = "Snake";
        return _this;
    }
    return Snake;
}(Animal));
var mySnake = new Snake("carnivoro");
var myAnimal = new Animal("erbivoro");
var snake = mySnake.info();
var animal = myAnimal.info();
console.log(snake);
console.log(animal);
