//buttons

class Button {
  String label;
  float x, y, w, h, textsize;
  color c1, c2;


  Button(String label, float x, float y, float w, float h, color c1, color c2, float textsize) {
    this.label = label;
    this.x = x;
    this.y = y;
    this.w = w;
    this.h = h;
    this.c1 = c1;
    this.c2 = c2;
    this.textsize = textsize;
  }

  void display() {
    rectMode(CENTER);
    
    if (mouseX > x-w/2 && mouseX < x+w/2 && mouseY > y-h/2 && mouseY < y+h/2) {
      fill(c2);
    } else {
      fill(c1);
    }
    stroke(#154f25);
    strokeWeight(5);
    rect(x, y, w, h, 20);
    fill(255);
    textSize(textsize);
    textAlign(CENTER, CENTER);
    textMode(CENTER);
    text(label, x, y - 5);
  }

  boolean clicked() {
    return (mouseX > x-w/2 && mouseX < x+w/2 && mouseY > y-h/2 && mouseY < y+h/2 && mousePressed);
  }
}
