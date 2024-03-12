import java.util.Arrays;

public class LABA1{
    public static int temp = 5;
    public static Thread[] MyThreads = new Thread[temp];
    volatile public static int[][] info = new int[3][];

    public static void main(String[] args) {
        System.out.println("Hello, World!");
        start();
    }

    public static void start() {
        info[0] = new int[]{1, 5, 9, 4, 2};    //TimeToStop
        info[1] = new int[]{5, 4, 6, 7, 8};    //kroks
        info[2] = new int[]{1, 2, 3, 4, 5};    //ID

        bubbleSort(info[0], info[1], info[2]);

        for (int i = 0; i <= temp-1; i++) {
            final int index = i;
            MyThreads[i] = new Thread(() -> calculate(index));
            MyThreads[i].start();
        }

        Thread stop = new Thread(LABA1::stopper);
        stop.start();
    }

    public static void calculate(int a) {
        int answer = 0;
        int howMany = 0;
        while (info[1][a] != 0) {
            answer += info[1][a];
            howMany++;
           //System.out.print("");
        }
        System.out.println("ID - " + info[2][a]);
        System.out.println("Answer - " + answer);
        System.out.println("How Many - " + howMany);
        System.out.println("//////////////////////////");
    }

    public static void stopper() {
        int mus = 0;
        for (int i = 0; i <= temp-1; i++) {
            try {
                Thread.sleep((info[0][i] - mus) * 1000);
            } catch (InterruptedException e) {
                e.printStackTrace();
            }
            info[1][i] = 0;
            mus = info[0][i];
        }
    }

    public static void bubbleSort(int[] array, int[] array2, int[] array3) {
        int len = array.length;
        for (int i = 1; i < len; i++) {
            for (int j = 0; j < len - i; j++) {
                if (array[j] > array[j + 1]) {
                    swap(array, j, j + 1);
                    swap(array2, j, j + 1);
                    swap(array3, j, j + 1);
                }
            }
        }
    }

    public static void swap(int[] array, int i, int j) {
        int temp = array[i];
        array[i] = array[j];
        array[j] = temp;
    }
}