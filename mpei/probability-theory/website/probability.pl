#!/usr/bin/perl

sub tasks
{
    my $tasks_file_path = shift;

    my $tasks_html_text = "";

    if(open(FH,$tasks_file_path))
    {
        # ������ ���� ����
        @arr=stat(FH); # ���������� �����, $arr[7] - ���������� ������
        if(read(FH,$tasks_file_text,$arr[7]))
        {
            $tasks_html_text=$tasks_html_text."<ol>";

            $tasks_file_text=~s/\r//g; # ������� ������� �������
            @tasks_strings=split/\n/,$tasks_file_text; # ��������� �� ������
            $tasks_count=$#tasks_strings+1; # ����� ����� = ����� ��������� �������
            for($tasks_index=0;$tasks_index<$tasks_count;$tasks_index++)
            {
                $#problems=-1; # ��������
                @problems=split/;/,$tasks_strings[$tasks_index]; # ���������
                $problems_count=$#problems+1; # ����� ��������� (������) � ������
                $chosen_problem_index=int(rand($problems_count)); # ��������� ����� ����� � ��������� 0-$n
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
print "<title>������� ����������� ����������� �� ������ ������������</title>\n";
print "</head>\n";
print "<body>\n";

print "<p>������ ����� �� \"�������� ����� �� ����������. ����� 4\" ��� ��������� ������� �.�., ��������� �.�., 2003 �.</p>";

print "<p><b>��-2</b>:</p>";
print tasks ( "/home/hostwpec/wpec.ru/data/probability-2-tasks.txt" );

print "<p><b>��-3</b>:</p>";
print tasks ( "/home/hostwpec/wpec.ru/data/probability-3-tasks.txt" );

print "<p><b>��-4</b>:</p>";
print tasks ( "/home/hostwpec/wpec.ru/data/probability-4-tasks.txt" );

print "<p>����������, �� ��������:</p>";
print "<ul>";
print "<li>������� ������ ����� (������� ����� �� ������������),</li>";
print "<li>������������� ��������,</li>";
print "<li>��������� ������.</li>";
print "</ul>";
print "<p>�����!</p>";

print "</body>\n";
print "</html>\n";

exit;
