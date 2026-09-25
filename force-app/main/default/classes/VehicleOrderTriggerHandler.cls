public class VehicleOrderTriggerHandler {

    public static void handleTrigger(
        List<Vehicle_Order__c> newOrders,
        Map<Id, Vehicle_Order__c> oldOrders,
        Boolean isBefore,
        Boolean isAfter,
        Boolean isInsert,
        Boolean isUpdate
    ) {

        if (isBefore && (isInsert || isUpdate)) {
            checkStock(newOrders);
        }
    }

    private static void checkStock(
        List<Vehicle_Order__c> orders
    ) {

        Set<Id> vehicleIds = new Set<Id>();

        for (Vehicle_Order__c order : orders) {

            if (order.Vehicle__c != null &&
                order.Status__c == 'Confirmed') {

                vehicleIds.add(order.Vehicle__c);
            }
        }

        if (vehicleIds.isEmpty()) {
            return;
        }

        Map<Id, Vehicle__c> vehicles = new Map<Id, Vehicle__c>([
            SELECT Id, Stock_Quantity__c
            FROM Vehicle__c
            WHERE Id IN :vehicleIds
        ]);

        for (Vehicle_Order__c order : orders) {

            if (!vehicles.containsKey(order.Vehicle__c)) {
                continue;
            }

            Vehicle__c vehicle =
                vehicles.get(order.Vehicle__c);

            if (vehicle.Stock_Quantity__c == null ||
                vehicle.Stock_Quantity__c <= 0) {

                order.addError(
                    'This vehicle is out of stock. Order cannot be confirmed.'
                );
            }
        }
    }
}