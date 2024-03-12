using System.Threading;


namespace TreadLab1C____
{
    internal class Program
    {
        static void Main(string[] args)
        {
            Console.WriteLine("Hello, World!");
            Start();
        }

        static public int temp = 5;
        static public Thread[] MyTreds = new Thread[temp];
        static public int[][] info = new int[3][];

        static void Start()
        {
            info[0] = new int[] { 1, 5, 9, 4, 2 };     //TimeToStop
            info[1] = new int[] { 5, 4, 6, 7, 8 };     //kroks
            info[2] = new int[] { 1, 2, 3, 4, 5, 6};  //ID

            BubbleSort(ref info[0], ref info[1], ref info[2]);

            for (int i = 0; i<=temp-1; i++)
            {
                MyTreds[i] = new Thread(Calculate);
                MyTreds[i].Start(i);
            }

            Thread stop = new Thread(Stopper);
            stop.Start();
        }

        static void Calculate(object? a)
        {
            int answer = 0;
            int howMany = 0;
            while (info[1][Convert.ToInt32(a)] != -1)
            {
                answer= answer + info[1][Convert.ToInt32(a)];
                howMany++;
            }
            Console.WriteLine("ID - "+ info[2][Convert.ToInt32(a)]);
            Console.WriteLine("Answer - " + answer);
            Console.WriteLine("How Many - " + howMany);
            Console.WriteLine("//////////////////////////");
        }
        static void Stopper()
        {
            int mus = 0;
            for(int i = 0; i<=temp-1;i++)
            {
                Thread.Sleep((info[0][i] - mus) * 1000);
                info[1][i] = -1;
                mus= info[0][i];
            }
        }

        static int[] BubbleSort(ref int[] array, ref int[] array2, ref int[] array3)
        {
            var len = array.Length;
            for (var i = 1; i < len; i++)
            {
                for (var j = 0; j < len - i; j++)
                {
                    if (array[j] > array[j + 1])
                    {
                        Swap(ref array[j], ref array[j + 1]);
                        Swap(ref array2[j], ref array2[j + 1]);
                        Swap(ref array3[j], ref array3[j + 1]);
                    }
                }
            }
            return array;
        }

        static void Swap(ref int e1, ref int e2)
        {
            var temp = e1;
            e1 = e2;
            e2 = temp;
        }
    }
}