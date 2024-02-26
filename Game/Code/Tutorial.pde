class Tutorial {
    boolean isActive;
    float highlightX, highlightY, highlightSize;
    PVector interactiveArea; // Position and size of the interactive area

    Tutorial(float x, float y, float size) {
        isActive = true;
        highlightX = x;
        highlightY = y;
        highlightSize = size;
        interactiveArea = new PVector(x, y, size); // Assuming a circular interactive area
    }

    void drawOverlay() {
        fill(150, 150, 150, 150); // semi-transparent grey
        rect(0, 0, width, height); // cover the entire screen
        clearInteractiveArea();
    }

    void clearInteractiveArea() {
        fill(0, 0); // clear or use background color
        ellipse(interactiveArea.x, interactiveArea.y, interactiveArea.z, interactiveArea.z); // Clearing the interactive area
    }

    void animateHighlight() {
        float animatedSize = highlightSize + sin(frameCount * 0.05) * 10;
        noFill();
        stroke(255, 204, 0);
        strokeWeight(4);
        ellipse(highlightX, highlightY, animatedSize, animatedSize);
    }

    void update() {
        if (isActive) {
            drawOverlay();
            animateHighlight();
        }
    }

    void checkInteraction() {
        if (isActive && dist(mouseX, mouseY, highlightX, highlightY) < highlightSize / 2) {
            // The mouse is within the interactive area
            // Implement interaction logic here
            isActive = false; // You can disable the tutorial after interaction
        }
    }
}
