global class VehicleOrderBatch
    implements Database.Batchable<SObject> {

    global Database.QueryLocator start(
        Database.BatchableContext bc
    ) {

        return Database.getQueryLocator([
            SELECT Id, Status__c, Vehicle__c
            FROM Vehicle_Order__c
            WHERE Status__c = 'Pending'
            AND Vehicle__c != null
            ORDER BY CreatedDate ASC
        ]);
    }

    global void execute(
        Database.BatchableContext bc,
        List<SObject> scope
    ) {

        List<Vehicle_Order__c> orders =
            new List<Vehicle_Order__c>();

        for (SObject record : scope) {
            orders.add((Vehicle_Order__c) record);
        }

        Set<Id> vehicleIds = new Set<Id>();

        for (Vehicle_Order__c order : orders) {

            if (order.Vehicle__c != null) {
                vehicleIds.add(order.Vehicle__c);
            }
        }

        if (vehicleIds.isEmpty()) {
            return;
        }

        Map<Id, Vehicle__c> vehicles =
            new Map<Id, Vehicle__c>([
                SELECT Id, Stock_Quantity__c
                FROM Vehicle__c
                WHERE Id IN :vehicleIds
                FOR UPDATE
            ]);

        Map<Id, Decimal> remainingStock =
            new Map<Id, Decimal>();

        for (Vehicle__c vehicle : vehicles.values()) {

            Decimal stock = vehicle.Stock_Quantity__c;

            if (stock == null) {
                stock = 0;
            }

            remainingStock.put(
                vehicle.Id,
                stock
            );
        }

        List<Vehicle_Order__c> ordersToConfirm =
            new List<Vehicle_Order__c>();

        Map<Id, Vehicle__c> vehiclesToUpdate =
            new Map<Id, Vehicle__c>();

        for (Vehicle_Order__c order : orders) {

            if (!vehicles.containsKey(order.Vehicle__c)) {
                continue;
            }

            Decimal stock =
                remainingStock.get(order.Vehicle__c);

            if (stock != null && stock > 0) {

                order.Status__c = 'Confirmed';

                ordersToConfirm.add(order);

                remainingStock.put(
                    order.Vehicle__c,
                    stock - 1
                );
            }
        }

        for (Id vehicleId : remainingStock.keySet()) {

            Vehicle__c vehicle =
                vehicles.get(vehicleId);

            Decimal oldStock =
                vehicle.Stock_Quantity__c;

            if (oldStock == null) {
                oldStock = 0;
            }

            Decimal newStock =
                remainingStock.get(vehicleId);

            if (newStock != oldStock) {

                vehicle.Stock_Quantity__c = newStock;

                vehiclesToUpdate.put(
                    vehicle.Id,
                    vehicle
                );
            }
        }

        if (!ordersToConfirm.isEmpty()) {
            update ordersToConfirm;
        }

        if (!vehiclesToUpdate.isEmpty()) {
            update vehiclesToUpdate.values();
        }
    }

    global void finish(
        Database.BatchableContext bc
    ) {

        System.debug(
            'Vehicle Order Batch completed successfully.'
        );
    }
}