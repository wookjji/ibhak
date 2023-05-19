package com.teamp.cau.util;

public class RandomScore {
    public double random(){
        double random = (Math.random()*100)+1;
        double u_random = (Math.round(random*100))/100.0;
        return u_random;
    }
    public double h_random(){
        double h_random = (Math.random()*50)+1;
        double hu_random = (Math.round(h_random*100))/100.0;
        return hu_random;
    }
    public double edScore(){
        double kor =h_random();
        double math =h_random();
        double eng =h_random();
        double Score = (kor+math+eng)/3;
        double u_Score =(Math.round(Score*100))/100.0;
        return u_Score;
    }
}
