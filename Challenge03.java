// Challenge 3: Emirps - Tuenti Programming Contest
// Author: Manuel Flores <manuelfloresv[at]gmail[.]com>
// Usage: java Challenge03

import java.io.*;
import java.util.*;

public class Challenge03 {

    private static boolean isPrime(int num) {
        // is even
        if (num%2==0) {
            return num==2;
        }

        // odds
        int i=3;
        double limit=Math.sqrt(num);
        while ((i<=limit) && (num%i!=0)) {
            i+=2;
        }
        return i>limit;
    }

    // returns the sum of emirps from first to last, plus accumulative sum
    public static long emirps(int first, int last, long sum) {
        // start from an even number
        if (first%2==0) {
            first++;
        }

        StringBuffer sb;
        int revnum;
        while (first<=last) {
            if (isPrime(first)) {
                sb=new StringBuffer(Integer.toString(first));
                revnum=Integer.parseInt(sb.reverse().toString());
                if (isPrime(revnum) && first!=revnum) { // emirp definition
                    sum+=first;
                }
            }
            first+=2;
        }
        return sum;
    }

    public static long emirps(int last) {
        return emirps(1, last, 0);
    }

    public static void main(String[] args) {
        List<Integer> input = new ArrayList<Integer>();

        try {
            BufferedReader in = new BufferedReader(new InputStreamReader(System.in));
            String s;
            while ((s = in.readLine()) != null) {
                // call multiple times is inefficient, see below!
                //System.out.println(emirps(Integer.parseInt(s)));
                input.add(Integer.parseInt(s));
            }
        } catch (IOException e) {

        }

        // Enhanced version:
        // 1. sort input numbers
        List<Integer> sortedinput = new ArrayList<Integer>(input);
        Collections.sort(sortedinput);

        // 2. partial calls
        HashMap<Integer, Long> sumemirps = new HashMap<Integer, Long>();
        int last, prev;
        long sum;

        for (int i=0; i<sortedinput.size(); i++) {
            last=sortedinput.get(i);
            if (i==0){
                sum=emirps(last);
            } else {
                prev=sortedinput.get(i-1);
                sum=emirps(prev+1, last, sumemirps.get(prev));
            }
            sumemirps.put(last, sum);
        }

        // 3. print in order
        for (Integer n: input) {
            System.out.println(sumemirps.get(n));
        }
    }
}
