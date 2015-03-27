#! /bin/bash
#echo begining
# set as=$#argv


	filename="http://m.cricbuzz.com/interview/playerlist"
	wget --quiet -O relative $filename

while :
do
	
	echo "Menu"

	echo "1.  Players name"

	echo "2.  Country"

	echo "3.  Role"

	echo "4.  Players having no.of matches greater than given number in ODIs "

	echo "5.  Players having no.of runs greater than given number in ODIs "

	echo "6.  Players having no.of wickets greater than given number in ODIs "

	echo "7. Exit "
	
	echo "enter the choice!"

	read s

	case $s in

	1)      echo "enter the player name "
		read name
		arr=($name)
		egrep -A 1 ${arr[1]}.*${arr[2]} relative > tem.txt
		url=$(grep -o 'http://[^"]*' tem.txt)
		echo "$url"
		wget --quiet $url -O data.json
		echo "-----------------------------------------------------"
		echo "-----------------------------------------------------"
		echo $name
		b='a. Country-'
		country=`java -jar json2txt.jar -i data.json "/playerInfo/team"`
		echo $b$country
		DoB=`java -jar json2txt.jar -i data.json "/playerInfo/DoB"`
		BirthYear=$(echo `expr "$DoB" : '\(.*[0-9][0-9][0-9][0-9]\)'`)
		CurrentYear=2015
		Age=$(($CurrentYear - $BirthYear))
		c='b. Age-'
		echo $c$Age
		player_role=`java -jar json2txt.jar -i data.json "/playerInfo/player_role"`
		d='c. Player Role-'		
		echo $d$player_role
		e='d. Bat/Bowl style-'
		l='/'
		playerBatStyle=`java -jar json2txt.jar -i data.json "/playerInfo/playerBatStyle"`

		playerBowlStyle=`java -jar json2txt.jar -i data.json "/playerInfo/playerBowlStyle"`
		echo $e$playerBatStyle$l$playerBowlStyle
		matches=`java -jar json2txt.jar -i data.json "/odiStats/Matches"`
		echo "-------ODI STATS---------"
		f='e. Number of matches-'­­­­­­­­­­­ 
		echo $f$matches
		runs=`java -jar json2txt.jar -i data.json "/odiStats/Runs"`
		g='f. Runs-'
		echo $g$runs
		wickets=`java -jar json2txt.jar -i data.json "/odiStats/WicketsTaken"`
		h='g. Wickets-'		
		echo $h$wickets
		echo "----------------------------------------------------"
		echo "----------------------------------------------------"
		;;

     	2)     	echo "enter the country name "
		read team
		filename=relative
		tempt=team
		mkdir "$tempt"
		while read -r line
			do
				[[ "$line" = "\{*" ]] && continue
				read -r line
				read -r line
				read -r line
				photo=$line
				echo $photo
				read -r line
				name=$line
				read -r line
				x=$line
				echo $x > tem.txt
				url=$(grep -o 'http://[^"]*' tem.txt)
				echo $url
				wget --quiet -O player.json $url 
				country=`java -jar json2txt.jar -i player.json "/playerInfo/team"`
				if [ "$country" == "$team" ]; then
					full=`java -jar json2txt.jar -i player.json "/playerInfo/completeName"`
					
					name=`java -jar json2txt.jar -i player.json "/playerInfo/nickName"`
					echo $name
					link=$(echo `expr "$photo" : '.*\(http:.*jpg\)'`)
					cd "$team"
					curl $link | convert - $name.jpg
					cd ..
				fi
		done < "$filename"
		;;
     	3)     	echo "enter the country role "
		read team
		filename=relative
		tempt=$team
		mkdir "$tempt"
		while read -r line
			do
				[[ "$line" = "\{*" ]] && continue
				read -r line
				read -r line
				read -r line
				photo=$line
				
				read -r line
				name=$line
				read -r line
				x=$line
				echo $x > tem.txt
				url=$(grep -o 'http://[^"]*' tem.txt)
				
				wget --quiet $url -O player.json 
				country=`java -jar json2txt.jar -i player.json "/playerInfo/player_role"`
				if [ "$country" == "$team" ]; then
					full=`java -jar json2txt.jar -i player.json "/playerInfo/completeName"`
					echo "$full"
					name=`java -jar json2txt.jar -i player.json "/playerInfo/nickName"`
					link=$(echo `expr "$photo" : '.*\(http:.*jpg\)'`)
					cd $tempt
					curl $link | convert - $name.jpg
					cd ..
				fi
		done < "$filename"
		;;

     	4)     	echo "Give the number of ODIs "
		read given
		z=0
		filename=relative
		tempt=team
		counter=1
		echo "S.No.            Name          Matches"
		while read -r line
			do
				[[ "$line" = "\{*" ]] && continue
				read -r line
				read -r line
				read -r line
				photo=$line
			
				read -r line
				name=$line
				read -r line
				x=$line
				echo $x > tem.txt
				url=$(grep -o 'http://[^"]*' tem.txt)
				
				wget --quiet $url -O player.json 
				matches=`java -jar json2txt.jar -i player.json "/odiStats/Matches"`
				if(("$matches" > "$z")); then
					if(("$matches" > "$given")); then
						full=`java -jar json2txt.jar -i player.json "/playerInfo/completeName"`
						a="."
						counter=$(($counter+1))
						echo $counter$a "    " $full "     " $matches
					fi
				fi
		done < "$filename"
		;;



     	5)     	echo "Give the number of runs "
		read given
		filename=relative
		tempt=team
		z=0
		counter=1
		echo "S.No.            Name         Run"
		while read -r line
			do
				[[ "$line" = "\{*" ]] && continue
				read -r line
				read -r line
				read -r line
				photo=$line
			
				read -r line
				name=$line
				read -r line
				x=$line
				echo $x > tem.txt
				url=$(grep -o 'http://[^"]*' tem.txt)
				
				wget --quiet $url -O player.json 
				runs=`java -jar json2txt.jar -i player.json "/odiStats/Runs"`
				if(("$runs" > "$z")); then
					if(("$runs" > "$given")); then
						full=`java -jar json2txt.jar -i player.json "/playerInfo/completeName"`
						a="."
						counter=$(($counter+1))
						echo $counter$a "    " $full "     " $runs
					fi
				fi
		done < "$filename"
		;;

	
     	6)     	echo "Give the number of wickets "
		read given
		filename=relative
		tempt=team
		z=0
		counter=1
		echo "S.No.            Name          Wickets"
		while read -r line
			do
				[[ "$line" = "\{*" ]] && continue
				read -r line
				read -r line
				read -r line
				photo=$line
			
				read -r line
				name=$line
				read -r line
				x=$line
				echo $x > tem.txt
				url=$(grep -o 'http://[^"]*' tem.txt)
				
				wget --quiet $url -O player.json 
				wickets=`java -jar json2txt.jar -i player.json "/odiStats/WicketsTaken"`
				if(("$wickets" > "$z")); then
					if(("$wickets" > "$given"));then
						full=`java -jar json2txt.jar -i player.json "/playerInfo/completeName"`
						a="."
						counter=$(($counter+1))
						echo $counter$a "    " $full "     " $wickets
					fi
				fi
		done < "$filename"
		;;
	
	7)	exit
		;;

esac

done



