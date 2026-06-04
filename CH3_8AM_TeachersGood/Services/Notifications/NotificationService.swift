//
//  NotificationService.swift
//  CH3_8AM_TeachersGood
//
//  Created by Syauqi Auliya M on 04/06/26.
//

import UserNotifications

class NotificationService {
    static let shared = NotificationService()

    // ask permission

    func requestPermission() async -> Bool {
        do {
            return try await UNUserNotificationCenter.current()
                .requestAuthorization(options: [.alert, .sound, .badge])
        } catch {
            return false
        }
    }

    // schedule

    func schedule(for interval: IntervalTime, affirmation: String = "Take a breath. You're doing better than you think.") {
        let center = UNUserNotificationCenter.current()

        // Clear existing before scheduling new ones
        center.removeAllPendingNotificationRequests()

        for (index, time) in times(for: interval).enumerated() {
            let content = UNMutableNotificationContent()
            content.title = "Thingy says..."
            content.body = affirmation
            content.sound = .default

            var components = DateComponents()
            components.hour = time.hour
            components.minute = time.minute

            let trigger = UNCalendarNotificationTrigger(
                dateMatching: components,
                repeats: true
            )

            let request = UNNotificationRequest(
                identifier: "solace_\(index)",
                content: content,
                trigger: trigger
            )

            center.add(request)
        }
    }

    func cancelAll() {
        UNUserNotificationCenter.current().removeAllPendingNotificationRequests()
    }

    // throughout the day based on teacher schedule

    private func times(for interval: IntervalTime) -> [(hour: Int, minute: Int)] {
        switch interval {
        case .onetime:    return [(7, 30)]
        case .twotimes:   return [(7, 30), (16, 0)]
        case .threetimes: return [(7, 30), (12, 0), (18, 0)]
        case .fourtimes:  return [(7, 30), (10, 0), (13, 0), (16, 0)]
        }
    }
    
    // Test
    func sendTestNotification() {
        let content = UNMutableNotificationContent()
        content.title = "Thingy says..."
        content.body = "Take a breath. You're doing better than you think."
        content.sound = .default

        let trigger = UNTimeIntervalNotificationTrigger(timeInterval: 5, repeats: false)

        let request = UNNotificationRequest(
            identifier: "solace_test",
            content: content,
            trigger: trigger
        )

        UNUserNotificationCenter.current().add(request)
    }
}
