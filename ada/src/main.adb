with Ada.Text_IO;

procedure Main is

   task type break_thread is
      entry Start;
   end;
   task type main_thread is
      entry Start(id : in Integer);
   end;

   Temp : constant Integer := 5;

   type Int_Array is array (Integer range <>) of Integer;

   TimeToStop : Int_Array(1..Temp) := ( 1, 5, 9, 4, 2);
   krok: Int_Array(1..Temp) := ( 5, 4, 6, 7, 8);
   Real_ID : Int_Array(1..Temp) := (1, 2, 3, 4, 5);


   procedure Swap(Arr: in out Int_Array; Index1, Index2: Integer) is
      Swap_Temp: Integer;
   begin
      Swap_Temp := Arr(Index1);
      Arr(Index1) := Arr(Index2);
      Arr(Index2) := Swap_Temp;
   end Swap;

   procedure Sort is
      N : constant Integer := TimeToStop'Length;
      Swapped : Boolean := True;
   begin
      while Swapped loop
         Swapped := False;
         for I in 1 .. N - 1 loop
            if TimeToStop(I) > TimeToStop(I + 1) then
               Swap(TimeToStop, I, I + 1);
               Swap(krok, I, I + 1);
               Swap(Real_ID, I, I + 1);
               Swapped := True;
            end if;
         end loop;
      end loop;
   end Sort;

   task body break_thread is
      mus : Integer;
   begin
      accept Start do
         break_thread.mus := 0;
      end Start;

      for i in 1..Temp loop
         delay Duration(TimeToStop(i)-mus);
         krok(i) := 0;
         mus := TimeToStop(i);
      end loop;
   end break_thread;

   task body main_thread is
      sum : Long_Long_Integer := 0;
      id : Integer;
      How_Many : Long_Long_Integer := 0;
      stop : Boolean := True;
   begin
      accept Start (id: in Integer) do
         main_thread.id := id;
      end Start;

      while stop loop
         if krok(id)=0 then
            stop:=False;
         else
         sum := sum + Long_Long_Integer(krok(id));
         How_Many := How_Many + 1;
         end if;
      end loop;
      Ada.Text_IO.Put_Line("Sum - " & sum'Img);
      Ada.Text_IO.Put_Line("How_Many - " & How_Many'Img);
      Ada.Text_IO.Put_Line("ID - " & Real_ID(id)'Img);
      Ada.Text_IO.Put_Line("\\\\\\\\\\\\\\\\\\\\\");
   end main_thread;

   b1 : break_thread;

   tasks : array(1..Temp) of main_thread;

begin
   Sort;
   for i in 1..Temp loop
      tasks(i).Start(i);
   end loop;
   b1.Start;
end Main;
