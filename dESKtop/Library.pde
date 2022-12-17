public static class Easing {
    // retは戻り値用変数 
    static float easeIn() {
        float ret=0;

        return ret;
    }

    static float easeOut() {
        float ret=0;

        return ret;
    }
}

<<<<<<< HEAD
class TextLib {
    TextLib() {
    }
}


=======
>>>>>>> 050c88ac8dcd246d9de731802d1329a7dba2b275
//--------------------------------------------------------------------------------------
// 以下ボタンライブラリ

import java.lang.reflect.Method;
import java.lang.reflect.Constructor;
import java.lang.reflect.InvocationTargetException;

PApplet papplet = this;

public class Button {
    // ボタンの設定のインスタンス生成
    Set set;
    // mainクラスのメソッド
    Object obj = null;
    // ボタンをクリックされたときにclickButtonEventの引数に渡される文字列
    String buttonName;
    // ボタンクリックとマウスクリックに関するフラグ
    boolean clickFlag = false;
    boolean clickOldOnFlag = false;
    boolean clickOnFlag = false;
    // 表示フラグ
    boolean visible = true;

    // ボタンの設定クラス
    class Set {
        // x座標, y座標, 幅, 高さ, 角丸の半径
        float x;
        float y;
        float width;
        float height;
        float radius;
        // ラベルの位置 X, Y, ラベルの文字サイズ
<<<<<<< HEAD
        float lavelX;
        float lavelY;
        float lavelSize;
        // Align beside:x軸, vertical:y軸
        int beside;
        int vertical;
        // ラベルの文字
        String textLavel;
=======
        float labelX;
        float labelY;
        float labelSize = 1;
        // Align horizontal:x軸, vertical:y軸
        int horizontal, vertical;
        // ラベルの文字
        String textlabel="";
>>>>>>> 050c88ac8dcd246d9de731802d1329a7dba2b275
        // ボタンの中の色, ボタンの外枠の色, ラベルの色
        color rectColor;
        color rectEdgeColor;
        color rectHoverColor;
        color textColor;

        // ボタンの設定のコンストラクタ
        Set() {
            // テキストの初期Alignは（CENTER, CENTER）
            this.align(CENTER, CENTER);
        }
        void position(float _x, float _y) {
            this.x = _x;
            this.y = _y;
<<<<<<< HEAD
            this.lavelPos();
=======
            this.labelPos();
>>>>>>> 050c88ac8dcd246d9de731802d1329a7dba2b275
        }
        void size(float _w, float _h, float _r) {
            this.width = _w;
            this.height = _h;
            this.radius = _r;
        }
        void buttonColor(color _rectColor, color _rectEdgeColor) {
            this.rectColor = _rectColor;
            this.rectEdgeColor = _rectEdgeColor;
        }
        void buttonHoverColor(color _rectHoverColor) {
            this.rectHoverColor = _rectHoverColor;
        }
<<<<<<< HEAD
        void lavel(String _text, float _lavelSize) {
            this.textLavel = _text;
            this.lavelSize = _lavelSize;
            this.lavelPos();
        }
        void align(int _beside, int _vertical) {
            this.beside = _beside;
            this.vertical = _vertical;
            this.lavelPos();
        }
        void lavelPos() {
            if (this.lavelSize > 0) {
                switch(this.beside) {
                case CENTER:
                    this.lavelX = this.x + this.width/2;
                    break;
                case LEFT:
                    this.lavelX = this.x;
                    break;
                case RIGHT:
                    this.lavelX = this.x + this.width;
=======
        void label(String _text, float _labelSize) {
            this.textlabel = _text;
            this.labelSize = _labelSize;
            this.labelPos();
        }
        void align(int _horizontal, int _vertical) {
            this.horizontal = _horizontal;
            this.vertical = _vertical;
            this.labelPos();
        }
        void labelPos() {
            if (this.labelSize > 0) {
                switch(this.horizontal) {
                case CENTER:
                    this.labelX = this.x + this.width/2;
                    break;
                case LEFT:
                    this.labelX = this.x;
                    break;
                case RIGHT:
                    this.labelX = this.x + this.width;
>>>>>>> 050c88ac8dcd246d9de731802d1329a7dba2b275
                    break;
                default:
                    println("Warning:Invalid Align");
                    throw new RuntimeException();
                }
                switch(this.vertical) {
                case CENTER:
<<<<<<< HEAD
                    this.lavelY = this.y + this.height/2;
                    break;
                case TOP:
                    this.lavelY = this.y;
                    break;
                case BOTTOM:
                    this.lavelY = this.y + this.height;
=======
                    this.labelY = this.y + this.height/2;
                    break;
                case TOP:
                    this.labelY = this.y;
                    break;
                case BOTTOM:
                    this.labelY = this.y + this.height;
>>>>>>> 050c88ac8dcd246d9de731802d1329a7dba2b275
                    break;
                default:
                    println("Warning:Invalid Align");
                    throw new RuntimeException();
                }
            }
        }
<<<<<<< HEAD
        void lavelColor(color _tectColor) {
=======
        void labelColor(color _tectColor) {
>>>>>>> 050c88ac8dcd246d9de731802d1329a7dba2b275
            this.textColor = _tectColor;
        }
    }

    // ボタンのコンストラクタ
    Button(Object obj, String _buttonName, float _x, float _y, float _w, float _h, float _r) {
        papplet.registerMethod("draw", this);
        this.obj = obj;

        this.buttonName = _buttonName;
        // 初期値の設定
        set = new Set();
        this.set.position(_x, _y);
        this.set.size(_w, _h, _r);
        this.set.buttonColor(200, 0);
        this.set.buttonHoverColor(255);
<<<<<<< HEAD
        this.set.lavelColor(0);
        this.set.lavel(_buttonName, 20);
=======
        this.set.labelColor(0);
        this.set.label("", 1);
>>>>>>> 050c88ac8dcd246d9de731802d1329a7dba2b275
        this.set.align(CENTER, CENTER);
    }

    // ボタン表示関数
    void draw() {
        if (!visible) return;
        push();

        // ボタン自体（ラベル以外）を表示
        this.buttonShow();
        // ラベルを表示
<<<<<<< HEAD
        this.lavelShow();
=======
        this.labelShow();
>>>>>>> 050c88ac8dcd246d9de731802d1329a7dba2b275

        // ボタンがクリックされたかを判別
        if (checkButtonClick()) {
            // クリックされたらclickButtonEvent関数を実行
            this.excution(this.buttonName);
        }

        pop();
    }

    // ボタン表示関数（ラベル以外）
    void buttonShow() {
        // ホバーしてないときの色
        if (!checkHover()) {
            fill(this.set.rectColor);
        }
        // ホバー時の色
        else {
            fill(this.set.rectHoverColor);
        }
        stroke(this.set.rectEdgeColor);
        rect(this.set.x, this.set.y, this.set.width, this.set.height, this.set.radius);
    }

    // ラベル表示関数
<<<<<<< HEAD
    void lavelShow() {
        fill(this.set.textColor);
        textAlign(this.set.beside, this.set.vertical);
        textSize(this.set.lavelSize);
        text(this.set.textLavel, this.set.lavelX, this.set.lavelY);
=======
    void labelShow() {
        fill(this.set.textColor);
        textAlign(this.set.horizontal, this.set.vertical);
        textSize(this.set.labelSize);
        text(this.set.textlabel, this.set.labelX, this.set.labelY);
>>>>>>> 050c88ac8dcd246d9de731802d1329a7dba2b275
    }

    // マウスがボタンにホバーしてるかの判別関数
    boolean checkHover() {
        if ( (mouseX > this.set.x && mouseX < this.set.x+this.set.width) &&
            (mouseY > this.set.y && mouseY < this.set.y+this.set.height) ) {
            return true;
        }
        return false;
    }

    // ボタンがクリックされたかの判別関数
    boolean checkButtonClick() {
        boolean return_flag = false;

        if (!this.checkHover()) {
            this.clickOnFlag = false;
            this.clickOldOnFlag = false;
        } else {
            if (!this.clickFlag) {
                this.clickOnFlag = mousePressed;
            }
            if (this.clickOldOnFlag && !mousePressed) {
                return_flag = true;
            }
            this.clickOldOnFlag = this.clickOnFlag;
        }
        if (!this.clickOnFlag)
            this.clickFlag = mousePressed;

        return return_flag;
    }

    void excution(String methodName) {
        try {
            Method m = this.obj.getClass().getDeclaredMethod(methodName);
            m.invoke(this.obj);
        }
        catch (NoSuchMethodException e) {
            println("Error: No function", methodName, "()");
            // throw new RuntimeException(e);
        }
        catch(NullPointerException e) {
            println("Error: No function", methodName, "()");
            // throw new RuntimeException(e);
        }
        catch (IllegalAccessException e) {
            throw new RuntimeException(e);
        }
        catch (InvocationTargetException e) {
            throw new RuntimeException(e);
        }
    }

    void visible(boolean disp) {
        this.visible = disp;
    }
}

// ここまでボタンライブラリ
//--------------------------------------------------------------------------------------
// 以下テキストライブラリ

public class TextLib {
    float animationSpeed = 1;
    
    TextLib() {
    }
    
    void setAnimationSpeed(float animationSpeed){
        this.animationSpeed = animationSpeed;
    }
    
    void showText(String text){
        char[] chars = text.toCharArray();
        //text(3,);
    }
}

// ここまでテキストライブラリ
//--------------------------------------------------------------------------------------
