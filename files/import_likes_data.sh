URL="http://pio:7070/events.json?accessKey=piokey"

echo "import is starting..."

curl -H "Content-Type: application/json" -d '
{
  "event" : "like",
  "entityType" : "user",
  "entityId" : "user-1",
  "targetEntityType" : "item",
  "targetEntityId" : "event-1"
}' ${URL}

curl -H "Content-Type: application/json" -d '
{
  "event" : "like",
  "entityType" : "user",
  "entityId" : "user-1",
  "targetEntityType" : "item",
  "targetEntityId" : "event-2"
}' ${URL}

curl -H "Content-Type: application/json" -d '
{
  "event" : "like",
  "entityType" : "user",
  "entityId" : "user-3",
  "targetEntityType" : "item",
  "targetEntityId" : "event-3"
}' ${URL}

curl -H "Content-Type: application/json" -d '
{
  "event" : "like",
  "entityType" : "user",
  "entityId" : "user-2",
  "targetEntityType" : "item",
  "targetEntityId" : "event-2"
}' ${URL}

curl -H "Content-Type: application/json" -d '
{
  "event" : "like",
  "entityType" : "user",
  "entityId" : "user-2",
  "targetEntityType" : "item",
  "targetEntityId" : "event-3"
}' ${URL}

curl -H "Content-Type: application/json" -d '
{
  "event" : "like",
  "entityType" : "user",
  "entityId" : "user-3",
  "targetEntityType" : "item",
  "targetEntityId" : "event-3"
}' ${URL}

curl -H "Content-Type: application/json" -d '
{
  "event" : "get_location",
  "entityType" : "user",
  "entityId" : "user-1",
  "targetEntityType" : "item",
  "targetEntityId" : "event-1"
}' ${URL}

curl -H "Content-Type: application/json" -d '
{
  "event" : "get_location",
  "entityType" : "user",
  "entityId" : "user-2",
  "targetEntityType" : "item",
  "targetEntityId" : "event-1"
}' ${URL}

curl -H "Content-Type: application/json" -d '
{
  "event" : "get_location",
  "entityType" : "user",
  "entityId" : "user-2",
  "targetEntityType" : "item",
  "targetEntityId" : "event-3"
}' ${URL}

curl -H "Content-Type: application/json" -d '
{
  "event" : "get_location",
  "entityType" : "user",
  "entityId" : "user-2",
  "targetEntityType" : "item",
  "targetEntityId" : "event-2"
}' ${URL}

curl -H "Content-Type: application/json" -d '
{
  "event" : "get_location",
  "entityType" : "user",
  "entityId" : "user-3",
  "targetEntityType" : "item",
  "targetEntityId" : "event-1"
}' ${URL}

echo "finished"
