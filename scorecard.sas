****************************************************************************
scorecard.sas HuangYY 2013-06-21
create a scorecard.
***************************************************************************;

%macro createScorecard(scorecard_set, train_set, var_dep, bins);
/* create a scorecard base on the train_set.
 * scorecard: output data set.
 *		the score result of logistic model. It include this col:
 *		var_indep: then independent variable's name.
 *		group: the group number of the independent variable's bin.
 *		range: the group range of the independent variable's bin.
 *		scoure: the score of the independent variable's bin.
 * train_set: input.
 * var_dep: input.
 *		The dependent variable's name.
 * bins: input.
 *		The group bins of independent varialbes. Its form is
 *		1:var_indep1:type1:range11=group11@range12=group12@... |
 *		2:var_indep2:type2:range21=group21@range22=group22@... |
 *		...
 *		n:var_indepn:typen:rangen1=groupn1@rangen2=groupn2@...
 */
 
	%iterBySep(createGroupFormat, |, %str(&bins.));
%mend;

%macro createGroupFormat(bin);
/* create the group format of the independent variable described in the bin.
 * the form of bins is:
 *		n:var_indep1:typen:rangen1=groupn1@rangen2=groupn2@...
 */
	%local n;
	%let n = %scan(&bin, 1, :);
	%local type;
	%let type = %scan(&bin., 3, :);
	%local groups;
	%let groups = %scan(&bin., -1, :);
	proc format;
		%if (%substr(&type, 1, 3) = num) %then %do;
		value group&n._var
		%end;
		%else %do;
		value $group&n._var
		%end;
		%iterBySep(listGroup, @, %str(&groups.))
		;
	run;
%mend;

%macro listGroup(group_bin);
	%str(&group_bin.)
%mend;
