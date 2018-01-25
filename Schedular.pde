

final int daysOfMonth[]= {
  31, 28, 31, 30, 31, 30, 31, 31, 30, 31, 30, 31
};
DottedNumber dNum;
PImage background;
PFont HOME;

String data[];
int unit_n[][] = new int[7][]; // number of time unit
int unit_k[][] = new int[7][]; // kind of time unit

String dw[] = {
  "SUN", "MON", "TUE", "WED", "THU", "FRI", "SAT"
};

/* function getDayOfWeek() converts a string to a number */
/* returns 0, 1, .. , 6 for "SUN", "MON, .. ,"SAT" */
int getDayOfWeek(String s) {
  for (int i = 0; i < 7; i++) {
    if (s.equals(dw[i])) {
      return i;
    }
  }

  return -1;
}

void setup() {
  size(480, 640);
  stroke(255);
  smooth();
  frameRate(100);
  drawCalender(year(), month(), day());
  dNum = new DottedNumber(6);
  HOME = loadFont("LaBambaLetPlain-48.vlw");
  background = loadImage("background.jpg");
  String d[];
  String n[] = {
    "", "", "", "", "", "", ""
  };
  String k[] = {
    "", "", "", "", "", "", ""
  };
  int dow, sum, i, j;
  data = loadStrings("life_week.txt");
  for (i = 0; i < data.length; i++) {
    // sprit one line to 3 strings
    // ex) "SUN,1,28" -> "SUN","1","28"
    d = data[i].split(",");
    dow = getDayOfWeek(d[0]); // dow is for day-of-week
    k[dow] += (d[1]+","); // concatenate only kind part
    n[dow] += (d[2]+","); // concatenate only time part
  }

  for (i = 0; i < 7; i++) {
    unit_k[i] = int(k[i].split(","));
    unit_n[i] = int(n[i].split(","));
  }

  for (i = 0; i < 7; i++) {
    // check the sum of time-unit for each day-of-week 
    sum = 0;
    for (j = 0; j < unit_k[i].length; j++) { 
      // unit_k[i][j]
      sum += unit_n[i][j];
    }

    if (sum != 96) {
      println("Data Error: The sum of quarter-hour-unit for "+dw[i]+ " is "+ sum +".");
    }
  }
}



int yo = 0;
int yo1 = 0;
int graph = 0;
int fade = 0;
int fade1 = 0;
int schedularf = 0;
int schedularf1 = 0;
int counter = 0;
int counter1 = 0;
int counter2 = 0;
int counter3 = 0;
int ss = 0;
int i1;
int j1;
float x1;
float y1;
float xx = 0;
float yy = 640;
float dx = 1;
float dy = 1;
//-----------------------calender------------------------//
int data1[][] = {
  {
    2, 2, 2, 2, 2, 2, 2
  }
  , 
  {
    2, 2, 2, 2, 2, 2, 2
  }
  , 
  {
    2, 2, 2, 2, 2, 2, 2
  }
  , 
  {
    2, 2, 2, 2, 2, 2, 2
  }
  , 
  {
    2, 2, 2, 2, 2, 2, 2
  }
  , 
  {
    2, 2, 2, 2, 2, 2, 2
  }
};


void block(int n, int m) {

  fill(255, 117, 0, 100);
  rect(70*m, 70*n+180, 60, 60, 10);
  if ((mouseX>70*m)&&(mouseX<70*m+60)&&(mouseY>70*n+180)&&(mouseY<70*n+240)) {
    if (mousePressed == true) {
      data1[n][m] = 1;
    } else if (mousePressed == false) {
      data1[n][m] = 2;
    }


    if (data1[n][m]==2) {
      noStroke();
      fill(255, 0, 84, 50);
      rect(70*m, 70*n+180, 60, 60, 10);
    }
    if (data1[n][m]==1) {

      switch(yo1) {
      case 0:
        ss = 5;
        break;
      }
    }
  }
}




// ツェラーの公式による曜日の算出
// 日曜=0 ... 土曜=6
int zeller(int y, int m, int d) {
  int h;
  if (m<3) {
    m+=12;
    y--;
  }
  h=(d+(m+1)*26/10+(y%100)+(y%100)/4+y/400-2*y/100)%7;
  h-=1;
  if (h<0) h+=7;
  return h;
}

// うるう年の判別
boolean isLeapYear(int y) {
  if (y%400==0) {
    return true;
  } else if (y%100==0) {
    return false;
  } else if (y%4==0) {
    return true;
  }
  return false;
}

// うるう年を考慮して「今月」の日数を求める
int getDaysOfMonth( int y, int m) {
  int days=daysOfMonth[m-1];
  if (m==2 && isLeapYear(y)) {
    days++;
  }
  return days;
}

// 「今月」のカレンダーを描画する
void drawCalender(int y, int m, int d) {
  int week=zeller(y, m, 0); // 「今月」1日の曜日を求める
  int days=getDaysOfMonth(y, m); // 「今月」の日数を求める
  textSize(40);
  fill(173, 255, 47); // 年/月を緑で表示
  text(y+"/"+m, 10, 60);
  textSize(15);
  for (int i=1; i<=days; i++) {
    if (i==d) {// 「今日」なら青字
      fill(0, 0, 255);
    } else {// 「今日」でないなら黒字
      fill(0);
      if ((i+week)%7==0) { // 日曜は赤字
        fill(255, 0, 0);
      }
    }
    String dd=(" "+i);
    dd=dd.substring(dd.length()-2);//文字列を右寄せっぽくする
    text(dd, (i+week)%7*((width+10)/7), ((i+week)/7+2)*((height-5)/9)+54);
  }
}
//---------------------------Graph---------------------------//
void setColor(int idx) {
  switch(idx) {
  case 1://睡眠
    fill(100, 100, 255); // red
    break;
  case 2://食
    fill(255, 255, 100);
    break;
  case 3://趣味
    fill(255, 100, 100);
    break;
  case 4://移動
    fill(255, 200, 255);
    break;
  case 5://勉強
    fill(100, 255, 100);
    break;
  case 6://その他
    fill(100, 100, 100);
    break;
  default:
    fill(255, 255, 255);
  }
}

void showGraph(float x, float y, int k[], int n[]) {
  int i;
  float w, h, tx, ty;

  for (i = 0; i < n.length; i++) {
    tx = x; // copy the value of x
    ty = y; // copy the value of y

      setColor(k[i]);
    if (k[i] == 2) {
      ty = ty - 6;
      h = 20;
    } else if (k[i] == 3) {
      ty = ty - 5;
      h = 18;
    } else {
      h = 8;
    }

    // the length of one time-unit on the window is 5
    w = n[i] * 4; 
    // draw the box
    rect(tx, ty, w, h);
    // move the current position to the right end of the box
    x += w;
  }
}

//---------------------------clock---------------------------//
int x = 300;
int offset1 = 120;
int offset2 = 50;

void makeDigitNum(String ts, int xpos, int ypos) {
  for (int i=0; i<ts.length (); i++) {
    if (ts.length() == 1) {
      dNum.makeNumber(10, xpos, ypos);
      dNum.makeNumber(int(str(ts.charAt(i))), xpos+offset2, ypos);
    } else {
      dNum.makeNumber(int(str(ts.charAt(i))), xpos+offset2*i, ypos);
    }
  }
}               


class DottedNumber {
  float x, y;
  float ew, eh, diameter;
  float offset;

  //
  DottedNumber(float diameter) {
    this.x = 0;
    this.y = 0;
    this.diameter = diameter;
    this.ew = diameter;
    this.eh = diameter;
    this.offset = 10;
  }

  //
  void makeNumber(int value, float px, float py) {
    if (value >= 0 && value <=9) {
      displayDots(value, px, py);
    } else {
      displayDots(10, px, py);
    }
  }
  //
  void displayDots(int pnum, float px, float py) {
    noStroke();
    fill(127, 255, 0);
    for (int i=0; i<7; i++) {
      for (int t=0; t<4; t++) {
        if (numbers[pnum][i*4 + t] == 1) {
          ellipse (px + (offset-4)*t+100, py + (offset-4)*i, ew, eh);
        }
      }
    }
  }
}

int[] n0 = {
  1, 1, 1, 1, 
  1, 0, 0, 1, 
  1, 0, 0, 1, 
  1, 0, 0, 1, 
  1, 0, 0, 1, 
  1, 0, 0, 1, 
  1, 1, 1, 1
};
int[] n1 = {
  0, 0, 0, 1, 
  0, 0, 0, 1, 
  0, 0, 0, 1, 
  0, 0, 0, 1, 
  0, 0, 0, 1, 
  0, 0, 0, 1, 
  0, 0, 0, 1
};
int[] n2 = {
  1, 1, 1, 1, 
  0, 0, 0, 1, 
  0, 0, 0, 1, 
  1, 1, 1, 1, 
  1, 0, 0, 0, 
  1, 0, 0, 0, 
  1, 1, 1, 1
};
int[] n3 = {
  1, 1, 1, 1, 
  0, 0, 0, 1, 
  0, 0, 0, 1, 
  1, 1, 1, 1, 
  0, 0, 0, 1, 
  0, 0, 0, 1, 
  1, 1, 1, 1
};
int[] n4 = {
  1, 0, 0, 1, 
  1, 0, 0, 1, 
  1, 0, 0, 1, 
  1, 1, 1, 1, 
  0, 0, 0, 1, 
  0, 0, 0, 1, 
  0, 0, 0, 1
};
int[] n5 = {
  1, 1, 1, 1, 
  1, 0, 0, 0, 
  1, 0, 0, 0, 
  1, 1, 1, 1, 
  0, 0, 0, 1, 
  0, 0, 0, 1, 
  1, 1, 1, 1
};
int[] n6 = {
  1, 1, 1, 1, 
  1, 0, 0, 0, 
  1, 0, 0, 0, 
  1, 1, 1, 1, 
  1, 0, 0, 1, 
  1, 0, 0, 1, 
  1, 1, 1, 1
};
int[] n7 = {
  1, 1, 1, 1, 
  0, 0, 0, 1, 
  0, 0, 0, 1, 
  0, 0, 0, 1, 
  0, 0, 0, 1, 
  0, 0, 0, 1, 
  0, 0, 0, 1
};
int[] n8 = {
  1, 1, 1, 1, 
  1, 0, 0, 1, 
  1, 0, 0, 1, 
  1, 1, 1, 1, 
  1, 0, 0, 1, 
  1, 0, 0, 1, 
  1, 1, 1, 1
};
int[] n9 = {
  1, 1, 1, 1, 
  1, 0, 0, 1, 
  1, 0, 0, 1, 
  1, 1, 1, 1, 
  0, 0, 0, 1, 
  0, 0, 0, 1, 
  1, 1, 1, 1
};
int[] nOff = {
  0, 0, 0, 0, 
  0, 0, 0, 0, 
  0, 0, 0, 0, 
  0, 0, 0, 0, 
  0, 0, 0, 0, 
  0, 0, 0, 0, 
  0, 0, 0, 0
};

int[][] numbers = {
  n0, n1, n2, n3, n4, n5, n6, n7, n8, n9, nOff
};              

void fadeinput() {
  switch(fade1) {
  case 1:
    schedularf1= schedularf1 + 3;
    fill(0, 0, 0, schedularf1);
    rect(0, 0, width, height);
    if (schedularf1 >= 255) {
      fade1 = 2;
      ss = nss;
    }
    break;
  case 2:
    schedularf1= schedularf1 - 3;
    fill(0, 0, 0, schedularf1);
    rect(0, 0, width, height);
    if (schedularf1 <= 0)
    {
      fade1 = 0;
      nss = ss;
    }
    break;
  }
}

int nss = 0;

void draw() {

  switch(ss) {
    //------------------------HOME--------------------------//
  case 0:
    image(background, xx, yy-640, 480, 720);
    //switch(fade) {
    //case 0:
    schedularf = schedularf + 1;
    //if (schedularf > 256) {
    // fade = 0;
    //}
    //break;
    //case 1:
    //schedularf = schedularf - 1;
    //if (schedularf < 0) {
    //schedularf = 0;
    //}
    //}
    textFont(HOME);
    noStroke();
    textSize(100);
    fill(255, 0, 0, schedularf);
    text("Schedular", 55, yy-500);
    textSize(30);
    text("MENU", width/2-45, yy-60);
    fill(255, 192, 203, 100);
    rect(0, yy, 160, 60, 10);
    fill(210, 180, 140, 100);
    rect(160, yy, 160, 60, 10);
    fill(152, 251, 152, 100);
    rect(320, yy, 160, 60, 10);

    fill(0);
    text("Clock", 50, yy+40);
    text("Clendar", 200, yy+40);
    text("Graph", 370, yy+40);



    if ((mouseY>600)&&(yy >= 580)) {
      yy = yy - dy;
    }
    if ((mouseY<300)&&(yy < 640)) {
      yy = yy + dy;
    }

    graph = 0;
    break;
    //--------------------------Clock-----------------------//
  case 1://Clock
    image(background, 0, 0, width, height+120);
    noStroke();
    textSize(30);
    fill(100, 100, 255);
    text("Home", 374, 630);

    //dezitalu
    String y = str(year());
    String mo = str(month());
    String d = str(day());
    String h = str(hour());
    String m = str(minute());
    String s = str(second());
    makeDigitNum(y, x-390, 20);
    makeDigitNum(mo, x-offset1-80, 20);
    makeDigitNum(d, x-50, 20);
    makeDigitNum(h, x-offset1*2-80, 100);
    makeDigitNum(m, x-offset1-50, 100);
    makeDigitNum(s, x-20, 100);
    text("year", 190, 60);
    text("month",280,60);
    text("day", 435, 60);
    text("h", 160, 140);
    text("m", 315, 140);
    text("s", 465, 140);

    schedularf = 0;
    break;
    //--------------------------calender---------------------//
  case 2:
    image(background, 0, 0, width, height+120);
    for (int i = 0; i<6; i++) {
      for (int j = 0; j<7; j++) {

        if (data1[i][j] > 0) {
          block(i, j);
        }
      }
    }
    drawCalender(year(), month(), day());
    fill(255, 0, 0);
    textSize(25);
    text("SUN", 4, 160);
    text("MON", 70, 160);
    text("THE", 143, 160);
    text("WED", 210, 160);
    text("THU", 282, 160);
    text("FRI", 357, 160);
    text("SAT", 425, 160);


    textSize(30);
    fill(100, 100, 255);
    text("Home", 374, 630);

    schedularf = 0;
    break;
    //-----------------------------Graph-------------------------//
  case 3:
    image(background, xx, 0, 480, 640);
    stroke(1);
    fill(40, 40, 100);
    rect(xx-100, 0, 100, 640);
    rect(xx-100, 100, 100, 70);
    rect(xx-100, 170, 100, 70);
    rect(xx-100, 240, 100, 70);
    rect(xx-100, 310, 100, 70);
    rect(xx-100, 380, 100, 70);
    rect(xx-100, 450, 100, 70);
    rect(xx-100, 520, 100, 70);
    textSize(20);
    fill(173, 255, 47);
    text("DAY", xx-64, 55);
    text("SUN", xx-64, 140);
    text("MON", xx-64, 210);
    text("THE", xx-64, 280);
    text("WED", xx-64, 350);
    text("THU", xx-64, 420);
    text("FRI", xx-64, 490);
    text("SAT", xx-64, 560);
    textSize(32);
    text("First lecture", xx+15, 150);
    text("Second lecture", xx+15, 200);
    text("Third lecture", xx+15, 250);
    text("Fourth lecture", xx+15, 300);
    text("Fifth lecture", xx+15, 350);
    text("Sleep", xx+130, 470);
    text("Hobby", xx+250, 470);
    text("Study", xx+370, 470);
    text("Eating", xx+130, 520);
    text("Move", xx+250, 520);
    text("Etc", xx+370, 520);

    fill(100, 100, 255);
    rect(xx+100, 450, 20, 15);//Sleep

    fill(255, 100, 100);
    rect(xx+220, 450, 20, 15);//Hobby

    fill(100, 255, 100);
    rect(xx+340, 450, 20, 15);//Study

    fill(255, 255, 100);
    rect(xx+100, 500, 20, 15);//Eating

    fill(255, 200, 255);
    rect(xx+220, 500, 20, 15);//Move

    fill(100, 100, 100);
    rect(xx+340, 500, 20, 15);//Etc


//--------------------------days----------------------------//
    switch(graph) {

    case 1:

      fill(255, 0, 0);
      x1 = 50;
      y1 = 50;
      text(dw[0], xx+10, 30);
      showGraph(xx+x1, y1, unit_k[0], unit_n[0]);
      break;
    case 2:
      fill(255, 0, 0);
      x1 = 50;
      y1 = 50;
      text(dw[1], xx+10, 30);
      showGraph(xx+x1, y1, unit_k[1], unit_n[1]);
      fill(255, 0, 0);
      textSize(25);
      text("Linear Algebra", xx+250, 150);
      text("Mathematics comprehensive exercises", xx+210, 200);
      text("exercises", xx+370, 220);
      text("Computer and Education", xx+210, 250);
      text("null", xx+300, 300);
      text("null", xx+300, 350);
      break;
    case 3:
      fill(255, 0, 0);
      x1 = 50;
      y1 = 50;
      text(dw[2], xx+10, 30);
      showGraph(xx+x1, y1, unit_k[2], unit_n[2]); 
      fill(255, 0, 0);
      textSize(25);
      text("Mathematical analysis", xx+230, 150);
      text("Information equipment", xx+210, 200);
      text("introduction", xx+360, 220);
      text("Communication", xx+260, 250);
      text("null", xx+300, 300);
      text("null", xx+300, 350);
      break;
    case 4:
      fill(255, 0, 0);
      x1 = 50;
      y1 = 50;
      text(dw[3], xx+10, 30);
      showGraph(xx+x1, y1, unit_k[3], unit_n[3]); 
      fill(255, 0, 0);
      textSize(25);
      text("Literacy", xx+280, 150);
      text("null", xx+300, 200);
      text("null", xx+300, 250);
      text("Environment and Industry", xx+210, 300);
      text("null", xx+300, 350);
      break;
    case 5:
      fill(255, 0, 0);
      x1 = 50;
      y1 = 50;
      text(dw[4], xx+10, 30);
      showGraph(xx+x1, y1, unit_k[4], unit_n[4]); 
      fill(255, 0, 0);
      textSize(25);
      text("Communication", xx+240, 150);
      text("null", xx+300, 200);
      text("null", xx+300, 250);
      text("null", xx+300, 300);
      text("null", xx+300, 350);
      break;
    case 6:
      fill(255, 0, 0);
      x1 = 50;
      y1 = 50;
      text(dw[5], xx+10, 30);
      showGraph(xx+x1, y1, unit_k[5], unit_n[5]);
      fill(255, 0, 0);
      textSize(25);
      text("Information representation", xx+210, 150);
      text("introduction", xx+340, 170);
      text("Information representation", xx+210, 200);
      text("introduction", xx+340, 220);
      text("Information representation", xx+210, 250);
      text("introduction", xx+340, 270);
      text("null", xx+300, 300);
      text("Hominal physiology", xx+250, 350);
      break;
    case 7:
      fill(255, 0, 0);
      x1 = 50;
      y1 = 50;
      text(dw[6], xx+10, 30);
      showGraph(xx+x1, y1, unit_k[6], unit_n[6]);
      break;
    }


    if ((mouseX<100)&&(xx <= 80)) {
      xx = xx + dx;
    }
    if ((mouseX>350)&&(xx > 0)) {
      xx = xx - dx;
    }
    textSize(30);
    fill(100, 100, 255);
    text("Home", 374, 630);

    schedularf = 0;
    break;
    //-----------------------Editor--------------------------//
  case 5:
    image(background, 0, 0, width, height+120);
    fill(255, 0, 0);
    textSize(50);
    text("Editor", 170, 50);
    fill(255, 0, 0, 60);
    rect(0, 100, 480, 500, 10);
    rect(10, 605, 110, 30);
    textSize(100);
    fill(255, 0, 0);
    text(nf(counter, 2), 160, 220);
    text(nf(counter1, 2), 290, 220);
    text(nf(counter2, 2), 160, 350);
    text(nf(counter3, 2), 290, 350);
    fill(255, 0, 0, 100);
    rect(174, 240, 30, 30);
    rect(220, 240, 30, 30);
    rect(305, 240, 30, 30);
    rect(351, 240, 30, 30);
    rect(174, 360, 30, 30);
    rect(220, 360, 30, 30);
    rect(305, 360, 30, 30);
    rect(351, 360, 30, 30);
    stroke(255, 0, 0);
    line(174, 255, 204, 255);
    line(189, 240, 189, 270);
    line(220, 255, 250, 255);
    line(305, 255, 335, 255);
    line(320, 240, 320, 270);
    line(351, 255, 381, 255);


    line(174, 375, 204, 375);
    line(189, 360, 189, 390);
    line(220, 375, 250, 375);
    line(305, 375, 335, 375);
    line(320, 360, 320, 390);
    line(351, 375, 381, 375);
    textSize(65);
    fill(255, 0, 0);
    text("Start", 0, 220);
    text("Finish", 0, 340);
    noStroke();
    textSize(30);
    text("Clendar", 20, 630);

    fill(100, 100, 255);
    text("Home", 374, 630);

    break;
  }
  fadeinput();
}




//---------------------------mouseClicked------------------//


void mouseClicked()
{
  if (ss == 0)
  {

    if ((0<mouseX)&&(mouseX<160)&&(yy<mouseY)&&(mouseY<yy+60)) {
      nss = 1;
      fade1 = 1;
    }
    if ((160<mouseX)&&(mouseX<320)&&(yy<mouseY)&&(mouseY<yy+60)) {
      nss = 2;
      fade1 = 1;
    }
    if ((320<mouseX)&&(mouseX<480)&&(yy<mouseY)&&(mouseY<yy+60)) {
      nss = 3;
      fade1 = 1;
    }
  }
  if (ss == 1)
  {
    if ((370<mouseX)&&(mouseX<460)&&(600<mouseY)&&(mouseX<640)) {
      nss = 0;
      fade1 = 1;
    }
  }
  if (ss == 2)
  {
    if ((370<mouseX)&&(mouseX<460)&&(600<mouseY)&&(mouseX<640)) {
      nss = 0;
      fade1 = 1;
    }
    if ((420<mouseX)&&(mouseX<480)&&(530<mouseY)&&(mouseY<590)) {
      for (i1 = 0; i1<6; i1++) {
        for (j1 = 0; j1<7; j1++) {
          data1[i1][j1] = 1;
        }
      }
    }
  }
  if (ss == 3)
  {
    if ((370<mouseX)&&(mouseX<460)&&(600<mouseY)&&(mouseX<640)) {
      nss = 0;
      fade1 = 1;
    }
    if ((xx-100<mouseX)&&(mouseX<xx)&&(100<mouseY)&&(mouseX<170)) {
      graph = 1;
    }
    if ((xx-100<mouseX)&&(mouseX<xx)&&(170<mouseY)&&(mouseX<240)) {
      graph = 2;
    }
    if ((xx-100<mouseX)&&(mouseX<xx)&&(240<mouseY)&&(mouseX<310)) {
      graph = 3;
    }
    if ((xx-100<mouseX)&&(mouseX<xx)&&(310<mouseY)&&(mouseX<380)) {
      graph = 4;
    }
    if ((xx-100<mouseX)&&(mouseX<xx)&&(380<mouseY)&&(mouseX<450)) {
      graph = 5;
    }
    if ((xx-100<mouseX)&&(mouseX<xx)&&(450<mouseY)&&(mouseX<520)) {
      graph = 6;
    }
    if ((xx-100<mouseX)&&(mouseX<xx)&&(520<mouseY)&&(mouseX<590)) {
      graph = 7;
    }
  }
  if (ss == 5)
  {
    if (174 <= mouseX && mouseX <= 204 && 240 <= mouseY && mouseY <= 270) {
      counter = counter + 1;
      if (counter >= 24) {
        counter = 0;
      }
    }

    if (220 <= mouseX && mouseX <= 250 && 240 <= mouseY && mouseY <= 270) {
      counter = counter - 1;
      if (counter <= 0) {
        counter = 24;
      }
      if (counter == 24) {
        counter = 23;
      }
    }

    if ( 305 <= mouseX && mouseX <= 335 && 240 <= mouseY && mouseY <= 270) {
      counter1 = counter1 + 1;
      if (counter1 >= 60) {
        counter1 = 0;
      }
    }

    if (351 <= mouseX && mouseX <= 381 && 240 <= mouseY && mouseY <= 270) {
      counter1 = counter1 - 1;
      if (counter1 <= 0) {
        counter1 = 60;
      }
      if ( counter1 == 60) {
        counter1 = 59;
      }
    }

    if (174 <= mouseX && mouseX <= 204 && 360 <= mouseY && mouseY <= 390) {
      counter2 = counter2 + 1;
      if (counter2 >= 24) {
        counter2 = 0;
      }
    }

    if (220 <= mouseX && mouseX <= 250 && 360 <= mouseY && mouseY <= 390) {
      counter2 = counter2 - 1;
      if (counter2 <= 0) {
        counter2 = 24;
      }
      if (counter2 == 24) {
        counter2 = 23;
      }
    }

    if ( 305 <= mouseX && mouseX <= 335 && 360 <= mouseY && mouseY <= 390) {
      counter3 = counter3 + 1;
      if (counter3 >= 60) {
        counter3 = 0;
      }
    }

    if (351 <= mouseX && mouseX <= 381 && 360 <= mouseY && mouseY <= 390) {
      counter3 = counter3 - 1;
      if (counter3 <= 0) {
        counter3 = 60;
      }
      if ( counter3 == 60) {
        counter3 = 59;
      }
    }
    if ((10<mouseX)&&(mouseX<110)&&(605<mouseY)&&(mouseX<630)) {
      ss = 2;
      counter = 0;
      counter1 = 0;
      counter2 = 0;
      counter3 = 0;
    }
    if ((370<mouseX)&&(mouseX<460)&&(600<mouseY)&&(mouseX<640)) {
      nss = 0;
      fade1 = 1;
      counter = 0;
      counter1 = 0;
      counter2 = 0;
      counter3 = 0;
    }
  }
}

