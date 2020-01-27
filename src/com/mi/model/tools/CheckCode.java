package com.mi.model.tools;

import java.awt.*;
import java.util.Random;
import static java.awt.image.ImageObserver.HEIGHT;
import static java.awt.image.ImageObserver.WIDTH;

public class CheckCode {

    public final static void drawBackground(Graphics g) {
        int x = (int) (Math.random() * WIDTH);
        int y = (int) (Math.random() * HEIGHT);
        int red = (int) (Math.random() * 255);
        int green = (int) (Math.random() * 255);
        int white = (int) (Math.random() * 255);
        g.setColor(new Color(red, green, white));
        g.fillRect(0, 0, 150, 40);
        g.drawOval(x, y, 5, 0);
    }

    public final static void drawRands(Graphics g, char[] rands) {
        // g.setColor(Color.BLUE);
        Random random = new Random();
        int red = random.nextInt(110);
        int green = random.nextInt(50);
        int blue = random.nextInt(50);
        g.setColor(new Color(red, green, blue));
        g.setFont(new Font(null, Font.ITALIC | Font.BOLD, 30));
        g.drawString("" + rands[0], 10, 27);
        g.drawString("" + rands[1], 35, 25);
        g.drawString("" + rands[2], 61, 28);
        g.drawString("" + rands[3], 96, 26);
    }

    public final static char[] generateCheckCode() {
        String chars = "0123456789ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz";
        char[] rands = new char[4];
        for (int i = 0; i < 4; i++) {
            int rand = (int) (Math.random() * 62);
            rands[i] = chars.charAt(rand);
        }
        return rands;
    }

}
