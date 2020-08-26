class Animal {
    type: string;
    vel: number = 5;
    name: string = "Any";

    constructor(type: string) {
        this.type = type;
    }

    info(): object {
        return {
            name: this.name,
            vel: this.vel,
            type: this.type
        };
    }
}

class Snake extends Animal {
    vel: number = 10;
    name: string = "Snake";
}

const mySnake: Animal = new Snake("carnivoro");
const myAnimal: Animal = new Animal("erbivoro");

const snake = mySnake.info();
const animal = myAnimal.info();

console.log(snake);
console.log(animal);