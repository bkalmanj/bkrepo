bkrepo

#To extract the metadata of an instance
python meta.py <ResourceGroupName> <VmName> <key>  --> Returns the value of the key from the nested json metadata output of the instance
python meta.py <ResourceGroupName> <Vmname>   ---> Returns the metadata output of the instance in json format.

#To extract value using a key from a nested json infra:
python nest.py <json_file> <key>

terraformrepo folder contains infrastructure 
