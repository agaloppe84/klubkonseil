module ApplicationHelper


  def which_cfe_view(instance, counter_proposal)
    response_1 = instance.q1
    response_2 = instance.q2
     if response_1 == "Plusieurs"
      if response_2 == "Artisan"
        cfe = "CMA"
      else
        cfe = "CCI"
      end
    else
      if response_2 == "Commercant"
        cfe = "CCI"
      elsif response_2 == "Artisan"
        cfe = "CMA"
      elsif response_2 == "Profession libérale"
        if counter_proposal == "SARLU" or counter_proposal == "SASU"
          cfe = "CCI"
        else
          cfe = "URSSAF"
        end
      elsif response_2 == "Je ne sais pas"
        cfe = "Explications ....."
      end
    end
  end

  def which_compta_view(instance, counter_proposal)
    response_4 = instance.q4
    if response_4 == "Plus"
      compta_mode = "Réel"
    elsif counter_proposal == "MICRO"
      compta_mode = "Franchise de TVA"
    elsif counter_proposal != "MICRO"
      compta_mode = "Franchise de TVA ou réel"
    end
  end

  def which_boss_title_view(counter_proposal)
    if counter_proposal == "SASU"
      titre_dirigeant = "P-DG assimilé salarié"
    elsif counter_proposal == "SAS"
      titre_dirigeant = "Assimilés salariés"
    elsif counter_proposal == "SARL"
      titre_dirigeant = "Associé majoritaire = Gérant TNS , Associé minoritaire = Gérant assimilé salarié ou TNS"
    else
      titre_dirigeant = "Gérant TNS"
    end
  end

  def which_social_cover_view(instance, boss_title)
    response_2 = instance.q2
    titre_dirigeant = boss_title

    if response_2 == "Profession libérale"
      social_cover = "URSSAF"
    elsif titre_dirigeant == "Assimilés salariés" or titre_dirigeant == "P-DG assimilé salarié"
      social_cover = "URSSAF"
    else
      social_cover = "RSI"
    end
  end

  def which_social_charges_view(instance, counter_proposal, cfe, boss_title)
    titre_dirigeant = boss_title
    response_3 = instance.q3
    if titre_dirigeant == "Gérant TNS"
      if counter_proposal == "MICRO"
        if response_3 == "prestation de service"
          if cfe == "URSSAF"
            social_charges = "22,5% du CA"
          else
            social_charges = "22,7% du CA"
          end
        else
          if response_3 == "Vente de marchandises"
            social_charges = "13,10% du CA"
          else
            social_charges = "22,7% du CA sur les prestations, 13,10% du CA sur la vente de marchandises"
          end
        end
      elsif counter_proposal == "EI"
        social_charges = "45% des bénéfices"
      elsif counter_proposal == "EI-EIRL"
        social_charges = "45% des prélèvements réels + les bénéfices"
      else
        social_charges = "45% de la rémunération + les bénéfices si ceux-ci sont supérieurs à 10% du capital"
      end
    elsif counter_proposal == "SARL"
      social_charges = "45% de la rémunération pour le gérant TNS et 78% de la rémunération pour le gérant assimilé salarié"
    else
      social_charges = "78% de la rémunération"
    end
  end

  def which_imposition_view(instance, counter_proposal)
    response_1 = instance.q1
    response_2 = instance.q2
    response_3 = instance.q3
    if response_1 == "Plusieurs"
      imposition = "IS = 15% du RCAI jusqu'a 38000 € puis 28%"
    else
      if counter_proposal == "MICRO"
        if response_3 == "prestation de service"
          if response_2 == "Profession libérale"
            imposition = "IR avec 34% d'abattement forfaitaire sur le CA"
          else
            imposition = "IR avec 50% d'abattement forfaitaire sur le CA"
          end
        elsif response_3 == "Vente de marchandises"
          imposition = "IR avec 71% d'abattement forfaitaire sur le CA"
        else
          imposition = "IR avec 50% d'abattement forfaitaire sur le CA sur les prestations, 71% d'abattement forfaitaire sur le CA sur les ventes"
        end
      elsif counter_proposal == "EI"
        imposition = "IR sur 45% des bénéfices majorés sauf si adhesion à un CGA"
      elsif counter_proposal == "EI-EIRL"
        imposition = "IS = 15% du RCAI jusqu'a 38000 € puis 28% ou IR sur les prélévements réels + 45% des bénéfices"
      else
        imposition = "IS = 15% du RCAI jusqu'a 38000 € puis 28% ou IR sur la rémunération + bénéfices"
      end
    end
  end

end
