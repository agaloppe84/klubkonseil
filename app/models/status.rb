class Status < ApplicationRecord

  def which_status
      if q1 == "Plusieurs"
        if q7 == "Oui"
          status = "SAS"
        else
          if q6 == "Oui"
            status = "SAS"
          else
            status = "SARL"
          end
        end
      else
        if q4 == "Plus"
          if q7 == "Oui"
            status = "SASU"
          else
            if q6 == "Oui"
              status = "SASU"
            else
              if q5 == "Faible"
                status = "EI"
              else
                if q5 == "Moyen"
                  status = "EI-EIRL"
                else
                  status = "SARLU"
                end
              end
            end
          end
        else
          if q7 == "Oui"
            status = "SASU"
          else
            if q6 == "Oui"
              if q5 == "Faible"
                status = "MICRO"
              else
                status = "SASU"
              end
            else
              if q5 == "Faible"
                status = "MICRO"
              else
                if q5 == "Moyen"
                  status = "EI"
                else
                  status = "SARLU"
                end
              end
            end
          end
        end
      end
  end


  def which_cfe
     if q1 == "Plusieurs"
      if q2 == "Artisan"
        cfe = "CMA"
      else
        cfe = "CCI"
      end
    else
      if q2 == "Commercant"
        cfe = "CCI"
      elsif q2 == "Artisan"
        cfe = "CMA"
      elsif q2 == "Profession libérale"
        if proposition == "SARLU" or proposition == "SASU"
          cfe = "CCI"
        else
          cfe = "URSSAF"
        end
      elsif q2 == "Je ne sais pas"
        cfe = "Explications ....."
      end
    end
  end

  def which_compta
    if q4 == "Plus"
      compta_mode = "Réel"
    elsif proposition == "MICRO"
      compta_mode = "Franchise de TVA"
    elsif proposition != "MICRO"
      compta_mode = "Franchise de TVA ou réel"
    end
  end

  def which_boss_title
    if proposition == "SASU"
      titre_dirigeant = "P-DG assimilé salarié"
    elsif proposition == "SAS"
      titre_dirigeant = "Assimilés salariés"
    elsif proposition == "SARL"
      titre_dirigeant = "Associé majoritaire = Gérant TNS , Associé minoritaire = Gérant assimilé salarié ou TNS"
    else
      titre_dirigeant = "Gérant TNS"
    end
  end

  def which_social_cover
    titre_dirigeant = self.which_boss_title

    if q2 == "Profession libérale"
      social_cover = "URSSAF"
    elsif titre_dirigeant == "Assimilés salariés" or titre_dirigeant == "P-DG assimilé salarié"
      social_cover = "URSSAF"
    else
      social_cover = "RSI"
    end
  end

  def which_social_charges
    titre_dirigeant = self.which_boss_title
    cfe = self.which_cfe

    if titre_dirigeant == "Gérant TNS"
      if proposition == "MICRO"
        if q3 == "prestation de service"
          if cfe == "URSSAF"
            social_charges = "22,5% du CA"
          else
            social_charges = "22,7% du CA"
          end
        else
          if q3 == "Vente de marchandises"
            social_charges = "13,10% du CA"
          else
            social_charges = "22,7% du CA sur les prestations, 13,10% du CA sur la vente de marchandises"
          end
        end
      elsif proposition == "EI"
        social_charges = "45% des bénéfices"
      elsif proposition == "EI-EIRL"
        social_charges = "45% des prélèvements réels + les bénéfices"
      else
        social_charges = "45% de la rémunération + les bénéfices si ceux-ci sont supérieurs à 10% du capital"
      end
    elsif proposition == "SARL"
      social_charges = "45% de la rémunération pour le gérant TNS et 78% de la rémunération pour le gérant assimilé salarié"
    else
      social_charges = "78% de la rémunération"
    end
  end

   def which_imposition
    if q1 == "Plusieurs"
      imposition = "IS = 15% du RCAI jusqu'a 38000 € puis 28%"
    else
      if proposition == "MICRO"
        if q3 == "prestation de service"
          if q2 == "Profession libérale"
            imposition = "IR avec 34% d'abattement forfaitaire sur le CA"
          else
            imposition = "IR avec 50% d'abattement forfaitaire sur le CA"
          end
        elsif q3 == "Vente de marchandises"
          imposition = "IR avec 71% d'abattement forfaitaire sur le CA"
        else
          imposition = "IR avec 50% d'abattement forfaitaire sur le CA sur les prestations, 71% d'abattement forfaitaire sur le CA sur les ventes"
        end
      elsif proposition == "EI"
        imposition = "IR sur 45% des bénéfices majorés sauf si adhesion à un CGA"
      elsif proposition == "EI-EIRL"
        imposition = "IS = 15% du RCAI jusqu'a 38000 € puis 28% ou IR sur les prélévements réels + 45% des bénéfices"
      else
        imposition = "IS = 15% du RCAI jusqu'a 38000 € puis 28% ou IR sur la rémunération + bénéfices"
      end
    end
  end

  def counter_proposal
    if q1 == "Plusieurs"
      if proposition == "SARL"
        contre_propo = "SAS"
      else
        contre_propo = "SARL"
      end
    else
      if q4 == "Moins"
        if proposition == "MICRO"
          contre_propo = "EI"
        else
          contre_propo = "MICRO"
        end
      else
        if proposition == "EI"
          contre_propo = "SARLU"
        else
          if proposition == "SARLU"
            contre_propo = "SASU"
          else
            contre_propo = "SARLU"
          end
        end
      end
    end
  end

  def proposal_reasons
    reason_1 = "En SARL, les choses ne seraient pas très différente. La création de l'entreprise et la lettre de mission du comptable seraient peut-être moins cher. Vous ne serez pas Assimilés Salariés mais Travailleur Non Salarié et donc paieraient vos cotisations sociales toujours à l'URSSAF mais à hauteur de 45% de votre rémunération. Point Important, vos bénéfices seraient également soumis à cotisation sociale s'il dépasse 10% du Capital Social de votre société ce qui ne sera pas le cas en SAS. En somme, c'est un statut intéressant car moins cher mais moins convoyeur de droit social. "
    reason_2 = "En SAS, les choses ne seraient pas très différente. La création de l'entreprise et la lettre de mission du comptable seraient peut-être plus cher. Vous serez tous Assimilés Salariés au lieu d'être TNS (pour le majoritaire) et donc paieraient vos cotisations sociales toujours à l'URSSAF mais à hauteur de 78% de votre rémunération. Votre droit social (notamment retraite) serait meilleur. Point Important, vos bénéfices ne seraient jamais soumis à cotisation sociale. En somme, c'est un statut intéressant car plus convoyeur de droit social et d'éventuel bonus (par les dividendes) mais plus cher. "
    reason_3 = "En SARLU, les choses ne seraient pas très différente. La création de l'entreprise et la lettre de mission du comptable seraient peut-être moins cher. Vous ne serez pas Assimilé Salarié mais Travailleur Non Salarié et donc paieraient vos cotisations sociales toujours à l'URSSAF mais à hauteur de 45% de votre rémunération. Point Important, vos bénéfices seraient également soumis à cotisation sociale s'il dépasse 10% du Capital Social de votre société ce qui ne sera pas le cas en SASU. En somme, c'est un statut intéressant car moins cher mais moins convoyeur de droit social. "
    reason_4 = "En Micro-Entreprise, les choses seraient considérablement différentes qu'en SASU. La Micro-Entreprise est simplement plus adaptée à votre hypothèse de CA. Ceci dit, la Micro-Entreprise ne vous apportera pas un droit social fort. Elle ne rajoutera pas de risque (puisqu'elle ne vous engagera dans aucune dette, pas même vers un comptable) mais ne vous protègera de rien. La Micro-Entreprise ne travaillera pas avec de la TVA et le CA sera le seul indicateur utilisé par l'Etat pour appeler vos cotisations sociales (22,5%) ou vos impôts. C'est un statut limité en CA, il ne faudra pas dépasser 33200€ par an et surtout pas la première année. En somme, cela peut être un statut intéressant au démarrage, surtout si les risques financiers sont faibles. "
    reason_5 = "En SASU, les choses ne seraient pas très différente. La création de l'entreprise et la lettre de mission du comptable seraient peut-être plus cher. Vous serez Assimilé Salarié au lieu d'être TNS et donc paieraient vos cotisations sociales toujours à l'URSSAF mais à hauteur de 78% de votre rémunération. Votre droit social (notamment retraite) serait meilleur. Point Important, vos bénéfices ne seraient jamais soumis à cotisation sociale. En somme, c'est un statut intéressant car plus convoyeur de droit social et d'éventuel bonus (par les dividendes) mais plus cher. "
    reason_6 = "En Micro-Entreprise, les choses seraient considérablement différentes qu'en SARLU. La Micro-Entreprise est simplement plus adaptée à votre hypothèse de CA. Elle ne rajoutera pas de risque (puisqu'elle ne vous engagera dans aucune dette, pas même vers un comptable) mais ne vous protègera de rien. Elle n'est donc pas adaptée au niveau de risque engagé. La Micro-Entreprise ne travaillera pas avec de la TVA et le CA sera le seul indicateur utilisé par l'Etat pour appeler vos cotisations sociales (22,5%) ou vos impôts. C'est un statut limité en CA, il ne faudra pas dépasser 33200€ par an et surtout pas la première année. En somme, cela peut être un statut intéressant au démarrage. "
    reason_7 = "En SARLU, les choses ne seraient pas très différente. La seule différence serait la création d'une personnalité juridique à part entière. Economiquement, la création couterait quelques centaines d'euros. Les cotisations sociales seront payées, toujours à l'URSSAF, mais sur votre rémunération pas sur prélèvement + bénéfices. En somme, c'est un statut qui apportera surtout une séparation de patrimoine et une responsabilité limitée. "
    reason_8 = "En SARLU, les choses ne seraient pas très différente. La seule différence serait le travail obligatoire d'un comptable pour attester les comptes de l'entreprise puisqu'elle sera une personnalité juridique à part entière. Economiquement, la création couterait quelques centaines d'euros et la lettre de mission du comptable serait à intégrer aux charges fixes de l'entreprise. Les cotisations sociales seront payées, toujours à l'URSSAF, mais sur votre rémunération pas sur vos bénéfices. En somme, c'est un statut qui apportera plus de maitrise, qui coutera plus cher, mais qui apportera surtout une séparation de patrimoine et une responsabilité limitée. "
    reason_9 = "En Micro-Entreprise, les choses seraient différentes qu'en EI. La Micro-Entreprise est simplement plus adaptée à votre hypothèse de CA. Elle vous permettra d'entrer dans un système stable puis seul le CA sera observé pour calculer vos cotisations sociales (22,5%) et vos impôts. La Micro-Entreprise ne travaillera pas avec de la TVA et il n'y aura pas de régularisation d'URSSAF, ce sera très simple à gérer. C'est un statut limité en CA, il ne faudra pas dépasser 33200€ par an et surtout pas la première année. En somme, cela peut être un statut intéressant au démarrage surtout si vos charges mensualisées sont faibles. "
    reason_10 = "En SARLU, les choses seraient très différentes qu'en Micro-Entreprise. La Micro-Entreprise est un statut très simple, très stable, sans risque mais avec une limite de CA à respecter chaque année. En SARLU, il n'y aura aucune limite. Vous créerez une personnalité juridique à part entière et devrez travailler avec un comptable. La création de l'entreprise, la lettre de mission, la base minimum de cotisations sociales de l'URSSAF seraient à payer quelque soit la réussite de l'entreprise. En somme, il s'agit de décider si vous créer une entreprise pour démarrer (la Micro-Entreprise) au risque de devoir limiter votre développement ou si vous créer une entreprise qui ne changera pas de statut (la SARLU) au risque de devoir lui venir en aide financièrement si le lancement est insatisfaisant ou si vous décidez de cesser l'activité."
    reason_11 = "En EI, les choses seraient différentes. Il n'y aura plus aucune limitation de CA. En EI, ce n'est pas votre CA l'important, mais vos bénéfices. Il n'y aura pas de déclaration de CA à faire mais c'est votre déclaration d'IR qui amènera des régularisations de la part de l'URSSAF. Vos cotisations seront toujours à payer à l'URSSAF, mais représenteront 45% de vos bénéfices. Vous ne serez pas obligé de travailler avec un comptable mais vous devrez adhérer à un Centre de Gestion Agréé pour éviter une majoration de vos bénéfices. En somme, c'est un statut plus difficile à appréhender mais intéressant car il vous permettra de développer votre activité sans limite."
    reason_12 = "En SARL, les choses ne seraient pas très différente. La création de l'entreprise et la lettre de mission du comptable seraient peut-être moins cher. Vous ne serez pas Assimilés Salariés mais Travailleur Non Salarié et donc paieraient vos cotisations sociales au RSI, à hauteur de 45% de votre rémunération. Le RSI ne serait pas si dangereux car les régularisations pourront être anticiper par le travail de votre comptable. En revanche, le droit social sera moins fort ou nécessitera d'être renforcé par des assurances privées. Point Important, vos bénéfices seraient également soumis à cotisation sociale s'il dépasse 10% du Capital Social de votre société ce qui ne sera pas le cas en SAS. En somme, c'est un statut intéressant car moins cher mais moins convoyeur de droit social. "
    reason_13 = "En SAS, les choses seraient plutôt différente. La création de l'entreprise et la lettre de mission du comptable seraient peut-être plus cher. Vous serez tous Assimilé Salarié au lieu d'être TNS (pour le majoritaire) et donc paieraient vos cotisations sociales à l'URSSAF, à hauteur de 78% de votre rémunération. Votre droit social (notamment retraite) serait quasi-équivalent à celui d'un salarié. Point Important, vos bénéfices ne seraient jamais soumis à cotisation sociale. En somme, c'est un statut intéressant car plus convoyeur de droit social et d'éventuel bonus (par les dividendes), c'est le seul statut qui permet de ne pas travailler avec le RSI, mais il est plus cher. "
    reason_14 = "En SARLU, les choses ne seraient pas très différente. La création de l'entreprise et la lettre de mission du comptable seraient peut-être moins cher. Vous ne serez pas Assimilés Salariés mais Travailleur Non Salarié et donc paieraient vos cotisations sociales au RSI, à hauteur de 45% de votre rémunération. Le RSI ne serait pas si dangereux car les régularisations pourront être anticiper par le travail de votre comptable. En revanche, le droit social sera moins fort ou nécessitera d'être renforcé par des assurances privées. Point Important, vos bénéfices seraient également soumis à cotisation sociale s'il dépasse 10% du Capital Social de votre société ce qui ne sera pas le cas en SASU. En somme, c'est un statut intéressant car moins cher mais moins convoyeur de droit social. "
    reason_15 = "En Micro-Entreprise, les choses seraient considérablement différentes qu'en SASU. La Micro-Entreprise est simplement plus adaptée à votre hypothèse de CA. Ceci dit, la Micro-Entreprise ne vous apportera pas un droit social fort. Elle ne rajoutera pas de risque (puisqu'elle ne vous engagera dans aucune dette, pas même vers un comptable) mais ne vous protègera de rien. Le RSI ne sera pas dangeureux, car il appelera à cotiser à un certain pourcentage de votre Chiffre d'Affaires, pas sur une estimation de vos bénéfices futurs. La Micro-Entreprise ne travaillera pas avec de la TVA et le CA sera le seul indicateur utilisé par l'Etat pour appeler vos cotisations sociales ou vos impôts. C'est un statut limité en CA, il ne faudra pas dépasser le plafond et surtout pas la première année. En somme, cela peut être un statut intéressant au démarrage, surtout si les risques financiers sont faibles. "
    reason_16 = "En SASU, les choses seraient plutôt différente. La création de l'entreprise et la lettre de mission du comptable seraient peut-être plus cher. Vous serez Assimilé Salarié au lieu d'être TNS et donc paieraient vos cotisations sociales à l'URSSAF, à hauteur de 78% de votre rémunération. Votre droit social (notamment retraite) serait quasi-équivalent à celui d'un salarié. Point Important, vos bénéfices ne seraient jamais soumis à cotisation sociale. En somme, la SAS est le seul statut qui permettrait de ne pas travailler avec le RSI mais il coûte plus cher en charges sociales. En somme, c'est un statut intéressant car plus convoyeur de droit social et d'éventuel bonus (par les dividendes), c'est le seul statut qui permet de ne pas travailler avec le RSI, mais il est plus cher. "
    reason_17 = "En Micro-Entreprise, les choses seraient considérablement différentes qu'en SARLU. La Micro-Entreprise est simplement plus adaptée à votre hypothèse de CA. Elle ne rajoutera pas de risque (puisqu'elle ne vous engagera dans aucune dette, pas même vers un comptable) mais ne vous protègera de rien. Elle n'est donc pas adaptée au niveau de risque engagé. La Micro-Entreprise ne travaillera pas avec de la TVA et le CA sera le seul indicateur utilisé par l'Etat pour appeler vos cotisations sociales (22,5%) ou vos impôts. C'est un statut limité en CA, il ne faudra pas dépasser 33200€ par an et surtout pas la première année. En somme, cela peut être un statut intéressant au démarrage. "
    reason_18 = "En SARLU, les choses ne seraient pas très différente. La seule différence serait la création d'une personnalité juridique à part entière. Economiquement, la création couterait quelques centaines d'euros. Les cotisations sociales seront payées, toujours au RSI, mais sur votre rémunération pas sur prélèvement + bénéfices. En somme, c'est un statut qui apportera surtout une séparation de patrimoine et une responsabilité limitée. "
    reason_19 = "En SARLU, les choses ne seraient pas très différente. La seule différence serait le travail obligatoire d'un comptable pour attester les comptes de l'entreprise puisqu'elle sera une personnalité juridique à part entière. Economiquement, la création couterait quelques centaines d'euros et la lettre de mission du comptable serait à intégrer aux charges fixes de l'entreprise. Les cotisations sociales seront payées, toujours au RSI, mais sur votre rémunération pas sur vos bénéfices. En somme, c'est un statut qui apportera plus de maitrise, qui coutera plus cher, mais qui apportera surtout une séparation de patrimoine et une responsabilité limitée. "
    reason_20 = "En Micro-Entreprise, les choses seraient différentes qu'en EI. La Micro-Entreprise est simplement plus adaptée à votre hypothèse de CA. Elle vous permettra d'entrer dans un système stable puis seul le CA sera observé pour calculer vos cotisations sociales et vos impôts. La Micro-Entreprise ne travaillera pas avec de la TVA et il n'y aura pas de régularisation du RSI, ce sera très simple à gérer. C'est un statut limité en CA, il ne faudra pas dépasser le plafond et surtout pas la première année. En somme, cela peut être un statut intéressant au démarrage surtout si vos charges mensualisées sont faibles. "
    reason_21 = "En SARLU, les choses seraient très différentes qu'en Micro-Entreprise. La Micro-Entreprise est un statut très simple, très stable, sans risque mais avec une limite de CA à respecter chaque année. En SARLU, il n'y aura aucune limite. Vous créerez une personnalité juridique à part entière et devrez travailler avec un comptable. La création de l'entreprise, la lettre de mission, la base minimum de cotisations sociales du RSI seraient à payer quelque soit la réussite de l'entreprise. En somme, il s'agit de décider si vous créer une entreprise pour démarrer (la Micro-Entreprise) au risque de devoir limiter votre développement ou si vous créer une entreprise qui ne changera pas de statut (la SARLU) au risque de devoir lui venir en aide financièrement si le lancement est insatisfaisant ou si vous décidez de cesser l'activité."
    reason_22 = "En EI, les choses seraient différentes. Il n'y aura plus aucune limitation de CA. En EI, ce n'est pas votre CA l'important, mais vos bénéfices. Il n'y aura pas de déclaration de CA à faire mais c'est votre déclaration d'IR qui amènera des régularisations de la part du RSI. Vos cotisations seront toujours à payer au RSI, mais représenteront 45% de vos bénéfices. Vous ne serez pas obligé de travailler avec un comptable mais vous devrez adhérer à un Centre de Gestion Agréé pour éviter une majoration de vos bénéfices. En somme, c'est un statut plus difficile à appréhender mais intéressant car il vous permettra de développer votre activité sans limite et avec moins de contraintes qu'une société (SARLU ou SASU)."

    if q2 == "Profession libérale"
      if proposition == "Micro"
        if q4 == "Je ne sais pas"
          reason_10
        else
          reason_11
        end
      elsif proposition == "EI"
        if q4 == "Moins"
          reason_9
        else
          reason_8
        end
      elsif proposition == "SARLU"
        if q4 == "Moins"
          reason_6
        else
          reason_5
        end
      elsif proposition == "SASU"
        if q4 == "Moins"
          reason_4
        else
          reason_3
        end
      elsif proposition == "SAS"
        reason_1
      elsif proposition == "SARL"
        reason_2
      else
        reason_7
      end
    else
      if proposition == "Micro"
        if q4 == "Je ne sais pas"
          reason_21
        else
          reason_22
        end
      elsif proposition == "EI"
        if q4 == "Moins"
          reason_20
        else
          reason_19
        end
      elsif proposition == "SARLU"
        if q4 == "Moins"
          reason_17
        else
          reason_16
        end
      elsif proposition == "SASU"
        if q4 == "Moins"
          reason_15
        else
          reason_14
        end
      elsif proposition == "SAS"
        reason_12
      elsif proposition == "SARL"
        reason_13
      else
        reason_18
      end
    end

  end






end
