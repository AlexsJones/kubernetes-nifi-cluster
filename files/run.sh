echo "working"

# This is a horrible hack because zookeeper returns a hostname the statefulsets do not understand
echo "Waiting to run nslookup..."
sleep 30
echo `nslookup nifi | sed -e 's/Address.*://' | tail -n +3` | sed -e 's/l /l\n/g' >>  /tmphosts
sed -i 's/nifi-0.nifi.nifi.svc.cluster.local/nifi-0.nifi.nifi.svc.cluster.local nifi-0/g' /tmphosts
sed -i 's/nifi-1.nifi.nifi.svc.cluster.local/nifi-1.nifi.nifi.svc.cluster.local nifi-1/g' /tmphosts
sed -i 's/nifi-2.nifi.nifi.svc.cluster.local/nifi-2.nifi.nifi.svc.cluster.local nifi-2/g' /tmphosts

cat /tmphosts >> /etc/hosts

./start_nifi.sh
