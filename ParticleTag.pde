Bubble[] bubbles;
Bubble aBubble;

void setup() {
    size(500, 500);
    // for(int i = 0; i < 100; i++) {
    //     bubbles[i] = new Bubble(250, 100);
    // }
    aBubble = new Bubble(250, 100);
}

void draw() {
    background(100);
    aBubble.move();
    aBubble.display();
    // for(int bubble of bubbles) {
    //     bubble.move();
    //     bubble.display();
    // }
}


class Bubble {
    public int x,y;
    float xOff,yOff;

    Bubble(int x, int y) {
        x = 50;
        y = 50;
        xOff = random(0, 1000);
        yOff = random(0, 1000);
    }

    void move() {
        xOff += 0.01;
        yOff += 0.01;

        // x = noise(this.xOff) * width;
        // y = noise(this.yOff) * height;
    }

    void draw(){
        move();
    }

   void display() {
        circle(x+50, y+50, 50);
    }
}
