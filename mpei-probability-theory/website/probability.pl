#!/usr/bin/perl

sub tasks
{
    my $tasks_file_path = shift;

    my $tasks_html_text = "";

    if(open(FH,$tasks_file_path))
    {
        # читаем весь файл
        @arr=stat(FH); # статистика файла, $arr[7] - количество байтов
        if(read(FH,$tasks_file_text,$arr[7]))
        {
            $tasks_html_text=$tasks_html_text."<ol>";

            $tasks_file_text=~s/\r//g; # убираем возврат каретки
            @tasks_strings=split/\n/,$tasks_file_text; # разделяем на строки
            $tasks_count=$#tasks_strings+1; # число строк = число элементов массива
            for($tasks_index=0;$tasks_index<$tasks_count;$tasks_index++)
            {
                $#problems=-1; # обнуляем
                @problems=split/;/,$tasks_strings[$tasks_index]; # разделяем
                $problems_count=$#problems+1; # число вариантов (данных) в строке
                $chosen_problem_index=int(rand($problems_count)); # случайное целое число в диапазоне 0-$n
                $tasks_html_text=$tasks_html_text."<li> 18.".$problems[$chosen_problem_index]."</li>";
            }

            $tasks_html_text=$tasks_html_text."</ol>";
        }

        close(FH);
    }

    return $tasks_html_text;
}


print "Content-type: text/html\n\n";
print "<html><head>\n";
print "<meta http-equiv=\"expires\" content=\"Thu, 1 Jan 1970 00:00:01 GMT\">\n";
print "<meta http-equiv=\"pragma\" content=\"no-cache\">\n";
print "<meta http-equiv=\"cache-control\" content=\"no-cache\">\n";
print "<meta http-equiv=\"cache-control\" content=\"no-store\">\n";
print "<meta http-equiv=\"Content-Type\" content=\"text/html; charset=windows-1251\">\n";
print "<meta http-equiv=\"Content-Language\" content=\"ru\">\n";
print "<link rel=\"stylesheet\" type=\"text/css\" href=\"http://www.wehse.ru/styles/main.css\">\n";
print "<title>Задания контрольных мероприятий по теории вероятностей</title>\n";
print "</head>\n";
print "<body>\n";

print "<p>Номера задач из \"Сборника задач по математике. Часть 4\" под редакцией Ефимова А.В., Поспелова А.С., 2003 г.</p>";

print "<p><b>КМ-2</b>:</p>";
print tasks ( "/home/hostwpec/wpec.ru/data/probability-2-tasks.txt" );

print "<p><b>КМ-3</b>:</p>";
print tasks ( "/home/hostwpec/wpec.ru/data/probability-3-tasks.txt" );

print "<p><b>КМ-4</b>:</p>";
print tasks ( "/home/hostwpec/wpec.ru/data/probability-4-tasks.txt" );

print "<p>Пожалуйста, не забудьте:</p>";
print "<ul>";
print "<li>указать номера задач (условия можно не переписывать),</li>";
print "<li>пронумеровать страницы,</li>";
print "<li>подписать работу.</li>";
print "</ul>";
print "<p>Удачи!</p>";

print "</body>\n";
print "</html>\n";

exit;
