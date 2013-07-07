****************************************************************************
util.sas HuangYY 2013-06-25
Some util codes.
***************************************************************************;

%macro iterBySep(iterF, sep, desc);
	%local n;
	%let n = 1;
	%do %while (%length(%scan(&desc., &n., &sep.)) ^= 0);
		%local par;
		%let par = %scan(&desc., &n., &sep.);
		%let n = %eval(&n. + 1);
		%&iterF.(%str(&par.))
	%end;
%mend;
