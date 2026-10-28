#show: doc => letter(
$if(title)$
  title: [$title$],
$endif$
$if(by-author)$
  author: (
$for(by-author)$
    (
      name: [$it.name.literal$],
$if(it.metadata.position)$
      position: [$it.metadata.position$],
$endif$
$if(it.metadata.signature)$
      signature: [$it.metadata.signature$],
$endif$
$for(it.affiliations/first)$
      affiliation: (
        name: [$it.name$],
$if(it.department)$
        department: [$it.department$],
$endif$
$if(it.address)$
        address: [$it.address$],
$endif$
$if(it.city)$
        city: [$it.city$],
$endif$
$if(it.postal-code)$
        postal-code: [$it.postal-code$],
$endif$
$if(it.country)$
        country: [$it.country$],
$endif$
      ),
$endfor$
    ),
$endfor$
  ),
$endif$
$if(address)$
  address: ($for(address)$[$address$],$endfor$),
$endif$
$if(date)$
  date: [$date$],
$endif$
$if(subject)$
  subject: [$subject$],
$endif$
$if(subject-title)$
  subject-title: [$subject-title$],
$endif$
$if(subject-suffix)$
  subject-suffix: [$subject-suffix$],
$endif$
$if(opening)$
  opening: [$opening$],
$endif$
$if(closing)$
  closing: [$closing$],
$endif$
$if(encl)$
  encl: ($for(encl)$[$encl$],$endfor$),
$endif$
$if(cc)$
  cc: ($for(cc)$[$cc$],$endfor$),
$endif$
$if(ps)$
  ps: [$ps$],
$endif$
$if(mainfont)$
  font: ("$mainfont$",),
$endif$
$if(fontsize)$
  fontsize: $fontsize$,
$endif$
$if(title-bg-image)$
  title-bg-image: [$title-bg-image$],
$endif$
$if(bg-image)$
  bg-image: [$bg-image$],
$endif$
  doc,
)
