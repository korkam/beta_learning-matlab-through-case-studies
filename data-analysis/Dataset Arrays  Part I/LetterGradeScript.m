% Script only runs if dataset array, grade, is in workspace with added columns

for m = 1:length(grade.Name)
   if grade.AVG(m) >= 90
       grade.Grade{m} = 'A';  % Curly Braces Here!
   elseif grade.AVG(m) >= 80
       grade.Grade{m} = 'B';  % Curly Braces Here!
   elseif grade.AVG(m) >= 70
       grade.Grade{m} = 'C';  % Curly Braces Here!
   elseif grade.AVG(m) >=60
       grade.Grade{m} = 'D';  % Curly Braces Here!
   else
       grade.Grade{m} = 'F';  % Curly Braces Here!
   end  
end



