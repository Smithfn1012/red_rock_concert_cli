require 'colorize'

class RedRockConcertCli::CLI

  def call
    system('clear') #clears terminal

    RedRockConcertCli::Scraper.scrape
    welcome
    main_menu_options
  end

  def welcome
    puts "      ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ ".yellow.bold
    puts "    //                                            \\\\".green.bold
    puts "   ////                                          \\\\\\".yellow.bold
    puts "  /// Welcome to Red Rocks Park and Amphitheatre!! \\\\\\".green.bold
    puts " ////                                              \\\\\\\\".yellow.bold
    puts "~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~".green.bold
  end

  def main_menu_options
    puts "Type '1' to get a list of upcoming concerts at the Red Rocks Amphitheater!".yellow
    puts "Type 'exit' to exit the program.".yellow
    main_menu_input
  end

  def sub_menu_options
    puts "Enter a concert number to get more information!".yellow
    puts "Type 'exit' to exit program".yellow
    sub_menu_input
  end

  def main_menu_input
    user_input = gets.strip

    if user_input == '1'
      print_concert_details(list_concerts)
      sub_menu_options
    elsif user_input.downcase == "exit"
      goodbye
    else
      invalid_choice
      main_menu_options
    end
  end

  def sub_menu_input
    user_input = gets.strip

    if user_input.to_i.between?(1, RedRockConcertCli::Concert.all.length)
      concert = RedRockConcertCli::Concert.all[user_input.to_i - 1]
      print_concert_details(concert)
      continue?
    elsif user_input.downcase == "exit"
      goodbye
    else
      invalid_choice
      sub_menu_options
    end
  end

  def list_concerts
    RedRockConcertCli::Concert.all.each.with_index(1) do |concert_choice, i|
      puts "#{i}. #{concert_choice.name}"
    end
  end

  def print_concert_details(list_concerts)
    user_input = gets.strip

    if user_input.to_i > 0
      concert_choice = RedRockConcertCli::Concert.find_by_index(user_input.to_i - 1)
      puts ""
      puts "~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~"
      puts "Red Rocks Park & Amphitheatre is Proud to Present:".green
      puts "~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~"        
      puts "#{concert_choice.name}".bold
      puts "#{concert_choice.opener}"
      puts "On #{concert_choice.date} at #{concert_choice.time}"
      puts "For tickets and more information, please visit:".cyan
      puts "#{concert_choice.tickets_URL}"
      puts ""
      puts "~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~"
    end
    main_menu_options
    list_concerts
  end

  def continue?
    puts "Type '1' for main menu, '2', to select another concert, 'exit' to exit program."

    user_input = gets.strip
    if user_input == '1'
      main_menu_options
    elsif user_input == '2'
      list_concerts
      sub_menu_options
    elsif user_input == "exit"
      goodbye
    else
      invalid_choice
      continue?
    end
  end

  def goodbye
    puts "Thank you for using the RedRockConcertCli gem! Please come back soon!"
    exit
  end

  def invalid_choice
    puts "Please check your selection and try again!"
  end
end
