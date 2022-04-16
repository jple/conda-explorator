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
echo "		<table>"
conda list -n $env | sed 1,3d | awk '{ print "<tr><td>" $1 "</td> <td>" $2 "</td> <td>" $3 "</td></tr>" }'
echo "		</table>"

#echo "            <pre>"
#conda env export -n $env | xargs -d'\n' printf "%b\n"
#echo "            </pre>"
echo "		</td> "
done;

echo "	</tr>"
echo "</table>"



