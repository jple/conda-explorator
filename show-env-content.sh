# Usage
# ./show-env-content.sh > out.html


ENV_NAMES=`conda env list | grep -v "home" | sed 1,2d | cut -d " " -f 1`


echo "
<!-- choices css -->
<link
  rel="stylesheet"
  href="https://cdn.jsdelivr.net/npm/choices.js@9.0.1/public/assets/styles/choices.min.css"
/>
"

echo "
<form>
    <label id=\"bob\"> Recherche de packages : </label>
    <br />
    <select name=\"coucou\" id=\"packages-selector\" multiple>
    </select>
</form>
"


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


echo "
<!-- import choices.js -->
<script src=\"https://cdn.jsdelivr.net/npm/choices.js@9.0.1/public/assets/scripts/choices.min.js\"></script>
"

echo "
<!-- import custom script -->
<script src=\"script.js\"></script>
"
