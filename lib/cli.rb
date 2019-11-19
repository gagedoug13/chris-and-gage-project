require './config/environment'
class Cli
    attr_accessor :guest, :event, :schedule
    require 'tty-prompt'
    PROMPT = TTY::Prompt.new
    
    def existing_guest
        
        
        guest_list = Guest.all.map {|guest| guest.name}
        guest_select = PROMPT.select("Select a user", (guest_list), active_color: :cyan)
        @guest = Guest.all.find {|guest| guest.name == guest_select}
        puts "Welcome back, #{@guest.name}."
        menu
    end 
    
    def new_guest
        puts "Create your username:"
        guest_name = gets.chomp
        puts ""
        @guest = Guest.create(name: guest_name)
        puts "Welcome, #{guest_name}!"
        menu
    end 
    
    def start
        puts "
        
    Hello!
        
        "
        puts "
    Welcome to Halloween Hallows.
        
        "
        choice = PROMPT.select("Have you been here before?", "Yes", "No", "Maybe", "Exit", active_color: :cyan)
            if choice == "Yes"
                # puts "Please choose your username from this list"
                existing_guest
            elsif choice == "No"
                new_guest
            elsif choice == "Maybe"
                puts "Bitch no you haven't." 
                new_guest
            else choice == "Exit"
                exit     
            end       
        #puts "welcome #{@guest.name}"
        menu
    end
    
    def menu
        choice = PROMPT.select("Select an option", "Build Schedule", "View Schedule", "Park Info", "DO NOT PUSH!", "<- Welcome Menu", "EXIT", active_color: :cyan)
            if choice == "Build Schedule"
                build_schedule
            elsif choice == "View Schedule"
                view_schedule
            elsif choice == "Park Info"
                park_info
            elsif choice == "DO NOT PUSH!"
                do_not_push
            elsif choice == "<- Welcome Menu"
                start 
            else choice == "EXIT"
                exit 
            end

    end 

    def build_schedule
       choice = PROMPT.select("Select one to filter by:", "Events by day", "Events by type", "Events by location", active_color: :cyan)
        if choice == "Events by day"
            event_list_by_day
        elsif choice == "Events by type"
            event_list_by_type
        else choice == "Events by location"
            event_list_by_location
        end
    end
    
    def event_list_by_day
       choice = PROMPT.select("Which day would you like to attend?", "Monday", "Tuesday", "Wednesday", "Thursday", active_color: :cyan)
        if choice == "Monday"
            monday_events = Event.all.select {|event| event.day == "Monday"}
            choice = PROMPT.select("Select an event!", (monday_events.map {|day| day.title}))
        elsif choice == "Tuesday"
            tuesday_events = Event.all.select {|event| event.day == "Tuesday"}
            choice = PROMPT.select("Select an event!", (tuesday_events.map {|day| day.title}))
        elsif choice == "Wednesday"
            wednesday_events = Event.all.select {|event| event.day == "Wednesday"}
            choice = PROMPT.select("Select an event!", (wednesday_events.map {|day| day.title}))
        else choice == "Thursday"
            thursday_events = Event.all.select {|event| event.day == "Thursday"}
            choice = PROMPT.select("Select an event!", (thursday_events.map {|day| day.title}))
        end
        puts `clear`
        Schedule.create(event_id: Event.find_by(title: choice).id, guest_id: @guest.id)
        view_schedule
    end
    
    def event_list_by_type
        choice = PROMPT.select("What type of event are you in the mood for?", "Parade", "Show", active_color: :cyan)
        if choice == "Parade"
            parades = Event.all.select {|event| event.event_type == "parade"}
            choice = PROMPT.select("Select a Parade!", (parades.map {|parade| parade.title}))
        else choice == "Show"
            shows = Event.all.select {|event| event.event_type == "show"}
            choice = PROMPT.select("Select a Show!", (shows.map {|show| show.title}))
        end
        puts `clear`
        Schedule.create(event_id: Event.find_by(title: choice).id, guest_id: @guest.id)
        view_schedule
    end

    def event_list_by_location
        choice = PROMPT.select("Choose a location in the park?", "Death Valley", "Grimland", "Wicked City", "Monsterville", "Ghost Town", active_color: :cyan)
        if choice == "Death Valley"
            deathvalley_loc = Event.all.select {|event| event.location == "Death Valley"}
            choice = PROMPT.select("Select an event!", (deathvalley_loc.map {|day| day.title}))
        elsif choice == "Grimland"
            grimland_loc = Event.all.select {|event| event.location == "Grimland"}
            choice = PROMPT.select("Select an event!", (grimland_loc.map {|day| day.title}))
        elsif choice == "Wicked City"
            wickedcity_loc = Event.all.select {|event| event.location == "Wicked City"}
            choice = PROMPT.select("Select an event!", (wickedcity_loc.map {|day| day.title}))
        elsif choice == "Monsterville"
            monsterville_loc = Event.all.select {|event| event.location == "Monsterville"}
            choice = PROMPT.select("Select an event!", (monsterville_loc.map {|day| day.title}))
        else choice == "Ghost Town"
            ghosttown_loc = Event.all.select {|event| event.location == "Ghost Town"}
            choice = PROMPT.select("Select an event!", (ghosttown_loc.map {|day| day.title}))
        end
        puts `clear`
        Schedule.create(event_id: Event.find_by(title: choice).id, guest_id: @guest.id)
        view_schedule
        
    end

    def park_info
        
        choice = PROMPT.select("
        
    This park is embedded with many Shows and Parades to attend. Choose wisely!
        
        ", "Build my Schedule", "This Place Sucks", active_color: :cyan)
            if choice == "Build my Schedule"
                build_schedule 
            else choice == "This Place Sucks"
                do_not_push      
            end     

    end

    def view_schedule
        @guest.reload
        puts "
        
        Here are your current events!
        
        "
        @guest.schedules.each { |schedule| puts schedule.event.title }
        
        
        menu
    end

    def do_not_push
        puts "
        
    YOU'LL DIE ALONE AND YOUR MOM HATES YOU
        
        
         "
         menu
    end
end