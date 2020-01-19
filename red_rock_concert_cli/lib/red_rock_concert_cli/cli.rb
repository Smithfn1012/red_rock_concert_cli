require 'colorize'

class RedRockConcertCli::CLI

  def call
    RedRockConcertCli::Scraper.scrape
    welcome
    list_concerts
    menu
  end

  def welcome
    puts "~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~"
    puts "   //                                            \\\\".green.bold
    puts "  ////                                          \\\\\\".green.bold
    puts " /// Welcome to Red Rocks Park and Amphitheatre!! \\\\".green.bold
    puts "////                                              \\\\".green.bold
    puts "~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~"
    puts "To see a current list of concerts, type list.".bold
    puts "To leave, please type exit."
  end

  def list_concerts
    input = gets.strip
    if input == "list"
      puts ""
      concerts = RedRockConcertCli::Concert.all
      concerts.each.with_index(1) {|concert, index| puts "#{index}. #{concert.name}"}
    elsif input == "exit"
      system "clear" or system "cls"
      exit
    else
      puts ""
      puts "You can type 'exit' to leave at anytime.".bold
      puts "To see a current list of concerts, type list."
      list_concerts
    end
  end

  def menu
    puts ""
    puts "Please select the concert number you wish to see. To leave, type 'exit'.".red.bold
      input = gets.strip

    if input.to_i > 0
      concert_choice = RedRockConcertCli::Concert.find_by_index(input.to_i - 1)
      puts ""
      puts "~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~"
      puts "Red Rocks Park & Amphitheatre is Proud to Present:".green
      puts ""
      puts "#{concert_choice.name}".bold
      puts "#{concert_choice.opener}"
      puts "On #{concert_choice.date} at #{concert_choice.time}"
      puts "For tickets and more information, please visit:".cyan
      puts "#{concert_choice.tickets_URL}"
      puts ""
      puts "~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~"
      menu
    elsif
      input == "exit"
      puts ""
      puts "Be safe out there!!".bold
      puts ""
      system "clear" or system "cls"
    else
      puts "Please try again."
      menu
    end
  end
end
