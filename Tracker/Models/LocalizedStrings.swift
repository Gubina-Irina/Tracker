//
//  LocalizedStrings.swift
//  Tracker
//
//  Created by Irina Gubina on 05.09.2025.
//
import Foundation

enum LocalizedStrings {
    // Main
    static let trackers = NSLocalizedString("trackers", comment: "Main screen title")
    static let creatingNewTracker = NSLocalizedString("new_tracker", comment: "Creating a new tracker")
    static let newHabit = NSLocalizedString("new_habit", comment: "New habit option")
    static let newIrregularEvent = NSLocalizedString("new_irregular_event", comment: "New irregular event option")
    static let cancel = NSLocalizedString("cancel", comment: "Cancel button")
    static let create = NSLocalizedString("create", comment: "Create button")
    static let done = NSLocalizedString("done", comment: "Done button")
    static let confirmDelete = NSLocalizedString("confirmDelete", comment: "Сonfirmation of deletion")
    static let filters = NSLocalizedString("filters", comment: "Filter button")

    // Categories
    static let habit = NSLocalizedString("habit", comment: "Habits category")
    static let irregularEvent = NSLocalizedString("irregular_event", comment: "Events category")
    static let noTrackers = NSLocalizedString("no_trackers", comment: "Empty state message")
    static let noSearchResult = NSLocalizedString("no_search_results", comment: "Empty state message")
    static let search = NSLocalizedString("search", comment: "Search placeholder")
    
        // Days full names
        static let sundayFull = NSLocalizedString("sunday_full", comment: "Sunday full name")
        static let mondayFull = NSLocalizedString("monday_full", comment: "Monday full name")
        static let tuesdayFull = NSLocalizedString("tuesday_full", comment: "Tuesday full name")
        static let wednesdayFull = NSLocalizedString("wednesday_full", comment: "Wednesday full name")
        static let thursdayFull = NSLocalizedString("thursday_full", comment: "Thursday full name")
        static let fridayFull = NSLocalizedString("friday_full", comment: "Friday full name")
        static let saturdayFull = NSLocalizedString("saturday_full", comment: "Saturday full name")
        
        // Days short names
        static let sundayShort = NSLocalizedString("sunday_short", comment: "Sunday short name")
        static let mondayShort = NSLocalizedString("monday_short", comment: "Monday short name")
        static let tuesdayShort = NSLocalizedString("tuesday_short", comment: "Tuesday short name")
        static let wednesdayShort = NSLocalizedString("wednesday_short", comment: "Wednesday short name")
        static let thursdayShort = NSLocalizedString("thursday_short", comment: "Thursday short name")
        static let fridayShort = NSLocalizedString("friday_short", comment: "Friday short name")
        static let saturdayShort = NSLocalizedString("saturday_short", comment: "Saturday short name")
    
    
    // Tracker properties
    static let trackerPlaceholderName = NSLocalizedString("tracker_placeholder_name", comment: "Placeholder name")
    static let category = NSLocalizedString("category", comment: "Name of the category table section")
    static let schedule = NSLocalizedString("schedule", comment: "Name of the schedule table section")
    static let emoji = NSLocalizedString("emoji", comment: "The header for the section name with emoji")
    static let color = NSLocalizedString("color", comment: "The header for the section name with color")
    static let everyDay =  NSLocalizedString("every_day", comment: "If all days of the week are selected in the schedule")
    
    //Category properties
    static let categoryPlaceholder = NSLocalizedString("category_placeholder", comment: "Category placeholder")
    static let addCategory = NSLocalizedString("add_category", comment: "Add category button")
    static let categoryTextFieldPlaceholder = NSLocalizedString("category_textField_placeholder", comment: "Category textField placeholder")
    static let editingCategory = NSLocalizedString("editing_category", comment: "Edite the category")
    static let newCategory = NSLocalizedString("new_category", comment: "Create new category")
    
    // Statistics
    static let statistics = NSLocalizedString("statistics", comment: "Statistics screen title")
    static let completedTrackers = NSLocalizedString("completed_trackers", comment: "Completed trackers count")
    static let statisticsPlaceholder = NSLocalizedString("statistics_placeholder", comment: "Statistics placeholder")
    static let bestStreak = NSLocalizedString("best_streak", comment: "Best streak statistic")
    
    // Actions
    static let delete = NSLocalizedString("delete", comment: "Delete button")
    static let edit = NSLocalizedString("edit", comment: "Edit button")
    
    //Error
    static let deleteCategoryConfirmation = NSLocalizedString("delete_category_confirmation", comment: "Deleting a category")
    
    //Edit screen
    static let editScreenTitle = NSLocalizedString("edit_screen_title", comment: "Title screen")
    static let save = NSLocalizedString("save", comment: "Save button")
    
    //Filters screen
    static let allTrackers = NSLocalizedString("all_trackers", comment: "Show all trackers")
    static let trackersToday = NSLocalizedString("trackers_today", comment: "Show only trackers for today")
    static let completed = NSLocalizedString("completed", comment: "Show only completed trackers")
    static let incomplete = NSLocalizedString("incomplete", comment: "Show only incomplete trackers")
    
}


//// Main
//"trackers" = "Трекеры";
//"new_tracker" = "Создание трекера";
//"new_habit" = "Новая привычка";
//"new_irregular_event" = "Новое нерегулярное событие";
//"edit_tracker" = "Редактирование трекера";
//"delete_tracker" = "Удалить трекер";
//"cancel" = "Отмена";
//"save" = "Сохранить";
//"add" = "Добавить";
//
//// Categories
//"habit" = "Привычка";
//"irregular_event" = "Нерегулярное событие";
//"no_trackers" = "Что будем отслеживать?";
//"no_search_results" = "Ничего не найдено";
//"search" = "Поиск";
//
//// Tracker properties
//"tracker_placeholder_name" = "Введите название трекера";
//"category" = "Категория";
//"schedule" = "Расписание";
//"emoji" = "Эмодзи";
//"color" = "Цвет";
//"every_day" = "Каждый день";
//"weekdays" = "Будние дни";
//"weekend" = "Выходные";
//
//// Days of week
//"monday" = "Понедельник";
//"tuesday" = "Вторник";
//"wednesday" = "Среда";
//"thursday" = "Четверг";
//"friday" = "Пятница";
//"saturday" = "Суббота";
//"sunday" = "Воскресенье";
//
//// Statistics
//"statistics" = "Статистика";
//"completed_trackers" = "Трекеров завершено";
//"best_streak" = "Лучшая серия";
//"perfect_weeks" = "Идеальные недели";
//"average_value" = "Среднее значение";
//
//// Actions
//"complete" = "Завершить";
//"undo_complete" = "Отменить завершение";
//"delete" = "Удалить";
//"pin" = "Закрепить";
//"unpin" = "Открепить";
//
//// Errors
//"error" = "Ошибка";
//"validation_error" = "Заполните все поля";
//"delete_confirmation" = "Уверены, что хотите удалить трекер?";
//
