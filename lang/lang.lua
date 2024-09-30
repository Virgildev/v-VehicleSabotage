Lang = {}

--READ READ READ READ READ READ READ READ READ READ READ READ READ READ READ READ READ READ READ READ READ READ READ READ READ READ READ READ 

--If you do not want to use english, replace the while table below with your launage!!!
--Wenn Sie kein Englisch verwenden möchten, ersetzen Sie die folgende Tabelle durch Ihre Sprache!!!
--Si vous ne souhaitez pas utiliser l'anglais, remplacez le tableau while ci-dessous par votre lavage!!!

Lang.Lang = {
    ['vehicle_torched'] = "You have torched the vehicle!",
    ['no_vehicle_found'] = "You need to target a valid vehicle to torch it.",
    ['fire_starting'] = "Get Away Before it starts!",
    ['vehicle_too_far'] = "Vehicle too far away!",
    ['fire_started'] = "Get Away!",
    ['action_canceled'] = "You canceled the arson attempt.",
    ['cutting_canceled'] = "Cutting canceled or failed!",
    ['skill_check_failed'] = "Skill check failed!",
    ['no_vehicle_nearby'] = "No vehicle nearby to cut the brakes!",
    ['failed_to_use_tool'] = "Failed to use the cutting tool!",
    ['brakes_cut'] = "All brakes have been cut!",
    ['car_bomb_planted'] = "A bomb has been planted in the backseat of the vehicle!",
    ['bomb_detonated'] = "The bomb has exploded!",
    ['bomb_disarmed'] = "The bomb has been successfully disarmed!",
    ['bomb_planting_cancelled'] = "You have cancelled the bomb planting.",
    ['no_bomb_found'] = "There is no bomb to disarm.",
    ['bomb_arm_progress'] = "Arming Bomb...",
    ['bomb_disarm_progress'] = "Disarming Bomb...",
    ['engine_started'] = "The vehicle engine has started! The bomb will detonate shortly.",
    ['part_removed_success'] = "Part deleted successfully.",
    ['part_removal_cancelled'] = "Part removal cancelled.",
    ['entity_not_exist'] = "Entity does not exist.",
    ['drill_success'] = "You successfully poked holes in the fuel tank!",
    ['drill_failure'] = "You failed to drill the fuel tank!",
    ['no_drill'] = "You need a drill to sabotage the vehicle!",
    ['drill_cancelled'] = "Drilling action has been cancelled.",
    ['sabotage_success'] = "Vehicle sabotage successful! The vehicle will explode soon.",
    ['sabotage_failed'] = "Failed to sabotage the vehicle! The vehicle is safe.",
    ['wheel_already_loosened'] = "The wheel nuts are already loosened!",
    ['loosen_canceled'] = "Loosening action has been canceled.",
    ['failed_to_loosen'] = "You failed to loosen the wheel nuts.",
    ['no_wheel_found'] = "No wheel found within reach!",
    ['tire_slashing_title'] = "Tire Slashed",
    ['tire_slash_success'] = "You have successfully slashed the tire!",
    ['poking_holes'] = "Poking Holes in the Fuel Tank...",
    ['cutting_breaks_progress'] = "Cutting the breaks...",
    ['slash_tire_target'] = "Slash Tire",
    ['disarm_car_bomb_target'] = "Disarm Car Bomb",
    ['removing_door_progress'] = "Remving Car Door...",
    ['remove_car_door_target'] = "Remove Car Door",
    ['remove_car_hood_target'] = "Remove Car Hood",
    ['remove_car_trunk_target'] = "Remove Car Trunk",
    ['pickup_tire'] = "Pickup Tire",
    ['placing_gasolinecanister_progress'] = "Placing Gasoline Canister...",
    ['must_wait'] = "You Must wait ",
    ['must_wait_2'] = "seconds before using the arson kit again.",
    ['cooldown_active'] = "You must wait before doing it again..."
}

--German!!!:


--[[
Lang.Lang = {
    ['vehicle_torched'] = "Sie haben das Fahrzeug angezündet!",
    ['no_vehicle_found'] = "Sie müssen ein gültiges Fahrzeug anvisieren, um es anzuzünden.",
    ['fire_starting'] = "Verschwinde, bevor es losgeht!",
    ['vehicle_too_far'] = "Fahrzeug zu weit entfernt!",
    ['fire_started'] = "Verschwinde!",
    ['action_canceled'] = "Sie haben den Brandanschlag abgebrochen.",
    ['cutting_canceled'] = "Schneiden abgebrochen oder fehlgeschlagen!",
    ['skill_check_failed'] = "Fähigkeitsprüfung fehlgeschlagen!",
    ['no_vehicle_nearby'] = "Kein Fahrzeug in der Nähe, um die Bremsen zu schneiden!",
    ['failed_to_use_tool'] = "Verwendung des Schneidwerkzeugs fehlgeschlagen!",
    ['brakes_cut'] = "Alle Bremsen wurden durchtrennt!",
    ['car_bomb_planted'] = "Eine Bombe wurde auf dem Rücksitz des Fahrzeugs platziert!",
    ['bomb_detonated'] = "Die Bombe ist explodiert!",
    ['bomb_disarmed'] = "Die Bombe wurde erfolgreich entschärft!",
    ['bomb_planting_cancelled'] = "Sie haben das Platzieren der Bombe abgebrochen.",
    ['no_bomb_found'] = "Es gibt keine Bombe zu entschärfen.",
    ['bomb_arm_progress'] = "Bombe wird scharf gemacht...",
    ['bomb_disarm_progress'] = "Bombe wird entschärft...",
    ['engine_started'] = "Der Fahrzeugmotor wurde gestartet! Die Bombe wird in Kürze detonieren.",
    ['part_removed_success'] = "Teil erfolgreich entfernt.",
    ['part_removal_cancelled'] = "Entfernen des Teils abgebrochen.",
    ['entity_not_exist'] = "Entität existiert nicht.",
    ['drill_success'] = "Sie haben erfolgreich Löcher in den Kraftstofftank gebohrt!",
    ['drill_failure'] = "Sie haben es nicht geschafft, den Kraftstofftank zu bohren!",
    ['no_drill'] = "Sie benötigen eine Bohrmaschine, um das Fahrzeug zu sabotieren!",
    ['drill_cancelled'] = "Bohren abgebrochen.",
    ['sabotage_success'] = "Fahrzeugsabote erfolgreich! Das Fahrzeug wird bald explodieren.",
    ['sabotage_failed'] = "Sabotage des Fahrzeugs fehlgeschlagen! Das Fahrzeug ist sicher.",
    ['wheel_already_loosened'] = "Die Radmuttern sind bereits gelockert!",
    ['loosen_canceled'] = "Lockerungsaktion wurde abgebrochen.",
    ['failed_to_loosen'] = "Sie haben es nicht geschafft, die Radmuttern zu lösen.",
    ['no_wheel_found'] = "Kein Rad in Reichweite gefunden!",
    ['tire_slashing_title'] = "Reifen Durchgeschnitten",
    ['tire_slash_success'] = "Sie haben den Reifen erfolgreich durchgeschnitten!",
    ['poking_holes'] = "Löcher in den Kraftstofftank bohren...",
    ['cutting_breaks_progress'] = "Bremsen werden geschnitten...",
    ['slash_tire_target'] = "Reifen Durchschneiden",
    ['disarm_car_bomb_target'] = "Auto-Bombe Entschärfen",
    ['removing_door_progress'] = "Autotür wird entfernt...",
    ['remove_car_door_target'] = "Autotür Entfernen",
    ['remove_car_hood_target'] = "Motorhaube Entfernen",
    ['remove_car_trunk_target'] = "Kofferraum Entfernen",
    ['pickup_tire'] = "Reifen Aufheben",
    ['placing_gasolinecanister_progress'] = "Benzinkanister platzieren...",
    ['must_wait'] = "Sie müssen warten",
    ['must_wait_2'] = "Sekunden, bevor Sie das Brandstiftungsset erneut verwenden.",
    ['cooldown_active'] = "Sie müssen warten, bevor Sie es erneut tun..."
}
]]


--French:

--[[
Lang.Lang = {
    ['vehicle_torched'] = "Vous avez incendié le véhicule !",
    ['no_vehicle_found'] = "Vous devez cibler un véhicule valide pour l'incendier.",
    ['fire_starting'] = "Éloignez-vous avant que ça ne commence !",
    ['vehicle_too_far'] = "Véhicule trop éloigné !",
    ['fire_started'] = "Éloignez-vous !",
    ['action_canceled'] = "Vous avez annulé la tentative d'incendie.",
    ['cutting_canceled'] = "Découpage annulé ou échoué !",
    ['skill_check_failed'] = "Échec de la vérification des compétences !",
    ['no_vehicle_nearby'] = "Aucun véhicule à proximité pour couper les freins !",
    ['failed_to_use_tool'] = "Échec de l'utilisation de l'outil de découpe !",
    ['brakes_cut'] = "Tous les freins ont été coupés !",
    ['car_bomb_planted'] = "Une bombe a été placée sur le siège arrière du véhicule !",
    ['bomb_detonated'] = "La bombe a explosé !",
    ['bomb_disarmed'] = "La bombe a été désamorcée avec succès !",
    ['bomb_planting_cancelled'] = "Vous avez annulé le placement de la bombe.",
    ['no_bomb_found'] = "Il n'y a pas de bombe à désamorcer.",
    ['bomb_arm_progress'] = "Arming Bomb...",
    ['bomb_disarm_progress'] = "Désarmement de la bombe...",
    ['engine_started'] = "Le moteur du véhicule a démarré ! La bombe va exploser sous peu.",
    ['part_removed_success'] = "Pièce supprimée avec succès.",
    ['part_removal_cancelled'] = "Suppression de la pièce annulée.",
    ['entity_not_exist'] = "L'entité n'existe pas.",
    ['drill_success'] = "Vous avez percé des trous dans le réservoir de carburant avec succès !",
    ['drill_failure'] = "Vous avez échoué à percer le réservoir de carburant !",
    ['no_drill'] = "Vous avez besoin d'une perceuse pour saboter le véhicule !",
    ['drill_cancelled'] = "Action de perçage annulée.",
    ['sabotage_success'] = "Sabotage du véhicule réussi ! Le véhicule va exploser bientôt.",
    ['sabotage_failed'] = "Échec du sabotage du véhicule ! Le véhicule est en sécurité.",
    ['wheel_already_loosened'] = "Les écrous de roue sont déjà desserrés !",
    ['loosen_canceled'] = "Action de desserrage annulée.",
    ['failed_to_loosen'] = "Vous avez échoué à desserrer les écrous de roue.",
    ['no_wheel_found'] = "Aucune roue trouvée à portée !",
    ['tire_slashing_title'] = "Pneu Tranché",
    ['tire_slash_success'] = "Vous avez réussi à trancher le pneu !",
    ['poking_holes'] = "Perçage de trous dans le réservoir de carburant...",
    ['cutting_breaks_progress'] = "Découpe des freins...",
    ['slash_tire_target'] = "Trancher le pneu",
    ['disarm_car_bomb_target'] = "Désarmer la bombe de voiture",
    ['removing_door_progress'] = "Retrait de la porte de la voiture...",
    ['remove_car_door_target'] = "Retirer la porte de la voiture",
    ['remove_car_hood_target'] = "Retirer le capot de la voiture",
    ['remove_car_trunk_target'] = "Retirer le coffre de la voiture",
    ['pickup_tire'] = "Ramasser le pneu",
    ['placing_gasolinecanister_progress'] = "Placement du bidon d'essence...",
    ['must_wait'] = "Vous devez attendre ",
    ['must_wait_2'] = "secondes avant d'utiliser à nouveau le kit anti-incendie.",
    ['cooldown_active'] = "Vous devez attendre avant de recommencer..."
}
]]