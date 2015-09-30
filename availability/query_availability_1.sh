#!/usr/bin/env bash
# query_availability.sh

source ./query_sample_avg.sh

function usage {
  echo "Usage: $0 [OPTION]..."
  echo "Query Availability"
  echo ""
  echo "  -S, --seconds        	Availability during these many seconds before to now"
  echo "  -X, --minutes        	Availability during these many minutes before to now"
  echo "  -H, --hours        	Availability during these many hours before to now"
  echo "  -D, --days        	Availability during these many days before to now"
  echo "  -W, --weeks        	Availability during these many weeks before to now"
  echo "  -M, --months        	Availability during these many months before to now"
  echo ""
}

seconds=0
minutes=0
months=0
weeks=0
days=0
hours=0

while [ $# -gt 0 ]; do
  case "$1" in
	-S|--seconds) seconds=$2; shift;;
	-X|--minutes) minutes=$2; shift;;
    	-H|--hours) hours=$2; shift;;
	-D|--days) days=$2; shift;;
	-W|--weeks) weeks=$2; shift;;
	-M|--months) months=$2; shift;;
  esac
  shift
done

#echo "hours=$hours, days=$days, weeks=$weeks, months=$months"

if  [ \( $seconds -eq 0 -a $minutes -eq 0 -a $hours -eq 0  -a   $days -eq 0  -a  $weeks -eq 0  -a  $months -eq 0  \) ] ; then

	usage
	exit 1
fi

compute_avg availability.status.event $seconds $minutes $hours $days $weeks $months  avg_returned_value ttc_returned_value

echo -e "             ----------------------------------"
echo -e "                Availability : $avg_returned_value%"
echo -e "             From : [$ttc_returned_value]       "
echo -e "             ----------------------------------"
