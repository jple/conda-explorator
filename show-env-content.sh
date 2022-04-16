# Usage
# ./show-env-content.sh > out.html


ENV_NAMES=`conda env list | grep -v "home" | sed 1,2d | cut -d " " -f 1`


echo "<table border=\"1\">"
echo "	<tr>"

# Create header with env names
for env in $ENV_NAMES;
do
echo "		<th> $env </th>"
done;

echo "	</tr>"


echo "	<tr style="vertical-align:top">"
for env in $ENV_NAMES;
do

echo "		<td> "
echo "		<table id=\"$env\" class=\"packages-list\">"
conda list -n $env | sed 1,3d | awk '{ print "<tr data-package-name=\""$1"\"><td class=\"package-name\">" $1 "</td> <td class=\"version\">" $2 "</td> <td class=\"build\">" $3 "</td></tr>" }'
echo "		</table>"

#echo "            <pre>"
#conda env export -n $env | xargs -d'\n' printf "%b\n"
#echo "            </pre>"
echo "		</td> "
done;

echo "	</tr>"
echo "</table>"



echo "<script src=\"script.js\"></script>"
