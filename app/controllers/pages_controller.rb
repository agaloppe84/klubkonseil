class PagesController < ApplicationController
  skip_before_action :authenticate_user!, only: [:home, :success]

  def home
    @statuses = ["MICRO", "EI", "EI-EIRL", "SARLU", "SASU", "SARL", "SAS"]
  end

  def success
    @response_1 = params[:tools][:question_1]
    @response_2 = params[:tools][:question_2]
    @response_3 = params[:tools][:question_3]
    @response_4 = params[:tools][:question_4]
    @response_5 = params[:tools][:question_5]
    @response_6 = params[:tools][:question_6]
    @response_7 = params[:tools][:question_7]


    if @response_1 == "Plusieurs"
      if @response_7 == "Oui"
        @status = "SAS"
      else
        if @response_6 == "Oui"
          @status = "SAS"
        else
          @status = "SARL"
        end
      end
    else
      if @response_4 == "Plus"
        if @response_7 == "Oui"
          @status = "SASU"
        else
          if @response_6 == "Oui"
            @status = "SASU"
          else
            if @response_5 == "Faible"
              @status = "EI"
            else
              if @response_5 == "Moyen"
                @status = "EI-EIRL"
              else
                @status = "SARLU"
              end
            end
          end
        end
      else
        if @response_7 == "Oui"
          @status = "SASU"
        else
          if @response_6 == "Oui"
            if @response_5 == "Faible"
              @status = "MICRO"
            else
              @status = "SASU"
            end
          else
            if @response_5 == "Faible"
              @status = "MICRO"
            else
              if @response_5 == "Moyen"
                @status = "EI"
              else
                @status = "SARLU"
              end
            end
          end
        end
      end
    end



    if @response_1 == "Plusieurs"
      if @response_2 == "Artisan"
        @cfe = "CMA"
      else
        @cfe = "CCI"
      end
    else
      if @response_2 == "Commercant"
        @cfe = "CCI"
      elsif @response_2 == "Artisan"
        @cfe = "CMA"
      elsif @response_2 == "Profession libérale"
        if @status == "SARLU" or @status == "SASU"
          @cfe = "CCI"
        else
          @cfe = "URSSAF"
        end
      elsif @response_2 == "Je ne sais pas"
        @cfe = "Explications ....."
      end
    end

    if @response_4 == "Plus"
      @compta_mode = "Réel"
    elsif @status == "MICRO"
      @compta_mode = "Franchise de TVA"
    elsif @status != "MICRO"
      @compta_mode = "Franchise de TVA ou réel"
    end

    if @status == "SASU"
      @titre_dirigeant = "P-DG assimilé salarié"
    elsif @status == "SAS"
      @titre_dirigeant = "Assimilés salariés"
    elsif @status == "SARL"
      @titre_dirigeant = "Associé majoritaire = Gérant TNS , Associé minoritaire = Gérant assimilé salarié ou TNS"
    else
      @titre_dirigeant = "Gérant TNS"
    end


    if @response_2 == "Profession libérale"
      @social_cover = "URSSAF"
    elsif @titre_dirigeant == "Assimilés salariés" or @titre_dirigeant == "P-DG assimilé salarié"
      @social_cover = "URSSAF"
    else
      @social_cover = "RSI"
    end


    if @titre_dirigeant == "Gérant TNS"
      if @status == "MICRO"
        if @response_3 == "prestation de service"
          if @cfe == "URSSAF"
            @social_charges = "22,5% du CA"
          else
            @social_charges = "22,7% du CA"
          end
        else
          if @response_3 == "Vente de marchandises"
            @social_charges = "13,10% du CA"
          else
            @social_charges = "22,7% du CA sur les prestations, 13,10% du CA sur la vente de marchandises"
          end
        end
      elsif @status == "EI"
        @social_charges = "45% des bénéfices"
      elsif @status == "EI-EIRL"
        @social_charges = "45% des prélèvements réels + les bénéfices"
      else
        @social_charges = "45% de la rémunération + les bénéfices si ceux-ci sont supérieurs à 10% du capital"
      end
    elsif @status == "SARL"
      @social_charges = "45% de la rémunération pour le gérant TNS et 78% de la rémunération pour le gérant assimilé salarié"
    else
      @social_charges = "78% de la rémunération"
    end


    if @response_1 == "Plusieurs"
      @imposition = "IS = 15% du RCAI jusqu'a 38000 € puis 28%"
    else
      if @status == "MICRO"
        if @response_3 == "prestation de service"
          if @response_2 == "Profession libérale"
            @imposition = "IR avec 34% d'abattement forfaitaire sur le CA"
          else
            @imposition = "IR avec 50% d'abattement forfaitaire sur le CA"
          end
        elsif @response_3 == "Vente de marchandises"
          @imposition = "IR avec 71% d'abattement forfaitaire sur le CA"
        else
          @imposition = "IR avec 50% d'abattement forfaitaire sur le CA sur les prestations, 71% d'abattement forfaitaire sur le CA sur les ventes"
        end
      elsif @status == "EI"
        @imposition = "IR sur 45% des bénéfices majorés sauf si adhesion à un CGA"
      elsif @status == "EI-EIRL"
        @imposition = "IS = 15% du RCAI jusqu'a 38000 € puis 28% ou IR sur les prélévements réels + 45% des bénéfices"
      else
        @imposition = "IS = 15% du RCAI jusqu'a 38000 € puis 28% ou IR sur la rémunération + bénéfices"
      end
    end

  end




end
