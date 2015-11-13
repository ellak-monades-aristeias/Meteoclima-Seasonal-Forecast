# Meteoclima-Seasonal-Forecast
**Tίτλος έργου: "Πληροφορικές βελτιώσεις στην εποχιακή πρόγνωση του καιρού"**

**Συνοπτική περιγραφή του Έργου**

Το Έργο "Πληροφορικές βελτιώσεις στην εποχιακή πρόγνωση του καιρού" έχει σαν σκοπό την εξέλιξη και βελτιστοποίηση των παράλληλων διαδικασιών εποχιακής πρόγνωσης καιρού, που παρέχεται ελεύθερα από την Ομάδα Δυναμικής της Ατμόσφαιρας και του Κλίματος (ACDG) του τμήματος Γεωγραφίας του Χαροκόπειου Πανεπιστημίου Αθηνών (HUA) στην ιστοσελίδα [meteoclima.gr](http://meteoclima.hua.gr/). Η πρόγνωση καιρού βασίζεται στη χρήση αριθμητικών (μαθηματικών) μοντέλων και απαιτεί ακριβή προσομοίωση των επικρατούντων ατμοσφαιρικών φαινομένων. Η σύγχρονη αριθμητική πρόγνωση απαιτεί γνώσεις προγραμματισμού υψηλού επιπέδου τόσο για τη χρήση όσο και για την εξέλιξη ενός ατμοσφαιρικού μοντέλου. To ατμοσφαιρικό μοντέλο που χρησιμοποιείται είναι το WRF-GLOBAL ή GWRF, ένα από τα πιο σύγχρονα και πλήρη από άποψη φυσικής, αριθμητικά μοντέλα πρόγνωσης καιρού. Το Έργο χωρίζεται σε δύο φάσεις. Η πρώτη φάση περιλαμβάνει τη βελτιστοποίηση της επιχειρησιακής λειτουργίας μέσω εκτεταμένων τροποποιήσεων σε scripting languages (Linux Shell scripts, NCL scripts) με σκοπό τον καλύτερο συγχρονισμό των διεργασιών εκτέλεσης του μοντέλου και τη διαχείριση και οπτικοποίηση μεγάλου όγκου δεδομένων ως αποτελέσμα των προσομοιώσεων. Η δεύτερη φάση περιλαμβάνει την ανάπτυξη μεθοδολογίας και λογισμικού στατιστικής αξιολόγησης (μέσω Linux Shell και NCL scripts) των προγνώσεων. Με το πέρας του έργου διαμορφώθηκε ένα ολοκληρωμένο, γρήγορο και αξιόπιστο σύστημα διαχείρισης, ανάλυσης, οπτικοποίησης και αξιολόγησης των εποχιακών προγνώσεων καιρού.

**Brief decription of the Project**

The Project "Computational improvements in seasonal weather forecasting" aims to the development and optimization of the parallel processes for seasonal weather forecasting. The seasonal weather forecasts are provided freely by the Atmospheric and Climate Dynamics Group (ACDG) of the Department of Geography of Harokopio University of Athens (HUA) at the website [meteoclima.gr](http://meteoclima.hua.gr/). The forecasts are based on the use of numerical (mathematical) models and requires accurate simulations of the prevailing atmospheric phenomena. Modern numerical weather forecasting requires high level programming skills both for the use and the development of an atmospheric model. The atmospheric numerical model WRF-GLOBAL or GWRF is used for the seasonal weather forecasting, because it is one of the most modern and complete in terms of physics model. The Project is divided into two parts. The first part includes the optimization of the operation of the model through extensive modifications in scripting languages (Linux Shell scripts, NCL scripts) to better synchronize the execution process of the model and the management and visualization of the large amounts of data as a result of simulations. The second part includes the development of statistical evaluation methodology and software (via Linux Shell and NCL scripts) for the forecasts. By the end of the project a complete, fast and reliable management system , analysis, visualization and evaluation of seasonal weather forecasts was developed.

**Περισσότερες πληροφορίες για το Έργο και τα παραδοτέα που ολοκληρώθηκαν**

Η εξέλιξη της υπολογιστικής ισχύος και των πολυεπεξεργαστικών συστημάτων επιτρέπει την υλοποίηση μεσοπρόθεσμων και εποχιακών προσομοιώσεων. Οι εποχιακές προγνώσεις καιρού παρέχουν πληροφορίες για το κατά πόσο μέσες μελλοντικές καιρικές συνθήκες μπορούν πράγματι να συμβούν σε ένα χρονικό εύρος από μερικούς μήνες μέχρι ένα έτος. Οι συγκεκριμένες προγνώσεις είναι εξαιρετικά απαιτητικές σε υπολογιστική ισχύ και συνεπώς πραγματοποιούνται σχεδόν αποκλειστικά από μεγάλα διεθνή επιχειρησιακά κέντρα πρόγνωσης καιρού και κλίματος (ECMWF, NCEP, NOAA). Η εποχιακή πρόγνωση καιρού είναι ιδιαίτερα χρήσιμη για τον πολιτικό σχεδιασμό διαχείρισης της ενέργειας, των υδάτινων αποθεμάτων, της υγείας, του τουρισμού κτλ., μέσω της παροχής έγκαιρων προειδοποιήσεων για επερχόμενα και ακραία καιρικά φαινόμενα. Η μεθοδολογία βασίζεται στην εφαρμογή πιθανολογικών προσομοιώσεων (ensemble simulations), οι οποίες προσεγγίζουν την πρόγνωση στοχαστικά παρά ντετερμινιστικά.

Η Ομάδα Δυναμικής της Ατμόσφαιρας και του Κλίματος (ΟΔΑΚ ή ACDG) του Τμήματος Γεωγραφίας, της Σχολής Περιβάλλοντος, Γεωγραφίας και Εφαρμοσμένων Οικονομικών, του Χαροκόπειου Πανεπιστημίου Αθηνών (ΧΠΑ ή HUA) παρέχει ελεύθερα από το Νοέμβριο του 2014 εποχιακές προγνώσεις καιρού, οι οποίες βασίζονται σε διαδοχικές ολοκληρώσεις του αριθμητικού μοντέλου [WRF-GLOBAL ή GWRF](http://www2.mmm.ucar.edu/wrf/users/) (Skamarock et al., 2008; Zhang et al., 2012). Το συγκεκριμένο προγνωστικό προϊόν αναφέρεται στην ευρύτερη περιοχή της Ευρώπης και προσφέρεται με τη μορφή θεματικών χαρτών. Η πρόσβαση του κοινού στην πληροφορία γίνεται ελεύθερα μέσω της ιστοσελίδας **http://meteoclima.gr**. Οι εποχιακές προγνώσεις προέρχονται από πιθανολογικές προσομοιώσεις, οι οποίες περιλαμβάνουν 15 μέλη με παγκόσμια κάλυψη σε ανάλυση 1.4deg x 1.4deg και προγνωστικό εύρος ένα έτος.

Shamarock W., Klemp J. B., Dudhia J., Gill D. O., Barker D. M., Duda M., Huang X.-Y., Wang W. and Powers, J. G. (2008). A description of the advanced research WRF version 3. NCAR technical note NCAR/TN/u2013475.

Zhang Y., Hemperly J., Meskhidze N. and Skamarock W. C. (2012). The Global Weather Research and Forecasting (GWRF) Model: Model Evaluation, Sensitivity Study, and Future Year Simulation.  Atmospheric and Climate Sciences, Vol. 2 No. 3, pp. 231-253.


**Σκοπός του έργου** είναι η εξέλιξη και βελτιστοποίηση της παραλληλίας του αριθμητικού μοντέλου WRF-GLOBAL (ανοιχτοί κώδικες FORTRAN). Θα αναπτυχθούν επίσης κώδικες σε scripting languages (Linux Shell Bash και [NCL](http://www.ncl.ucar.edu/)), για την στατιστική ανάλυση βασικών μετεωρολογικών παραμέτρων και για την παροχή γραφικών σχετικά με τις θερμοκρασιακές ανωμαλίες με βάση μέσες μηνιαίες κλιματολογικές τιμές, με διαγράμματα τύπου spaghetti, τη χωρική απεικόνιση της πιθανότητας εμφάνισης μηνιαίας βροχόπτωσης που υπερβαίνει προκαθορισμένα όρια, καθώς επίσης και τις επισημάνσεις ακραίων καιρικών φαινομένων.

**To έργο χωρίζεται σε 2 φάσεις με το χρονοδιάγραμμα που φαίνεται παρακάτω:**

**Χρονοδιάγραμμα**      

| **Φάσεις**           | **Εβδομάδες**  |
|:-------------:| -----:|
| Φάση 1 | 1η – 9η εβδομάδα |
| Φάση 2     | 6η – 12η εβδομάδα|

**Επεξήγηση φάσεων:**

**Φάση 1: Βελτιστοποίηση επιχειρησιακής λειτουργίας**

Βελτιστοποίηση παραλληλοποίησης σε Message Passing Interface (MPI) ανοιχτών κωδίκων FORTRAN με σκοπό την αποδοτικότερη εκτέλεση του μοντέλου WRF-GLOBAL. Η βελτιστοποίηση της επιχειρησιακής λειτουργίας περιελάμβανε εκτεταμένες τροποποιήσεις σε scripting languages (Linux Shell scripts, NCL scripts) με σκοπό τον καλύτερο συγχρονισμό των διεργασιών εκτέλεσης του μοντέλου και τη διαχείριση μεγάλου όγκου δεδομένων (big data) ως αποτελέσμα των προσομοιώσεων.

**Φάση 2: Αξιολόγηση αποτελεσμάτων**

Στη συγκεκριμένη φάση αναπτύχθηκε μεθοδολογία και λογισμικό αξιολόγησης των προγνώσεων. Η αξιολόγηση βασίστηκε σε καθιερωμένους στατιστικούς ελέγχους των προγνωστικών πεδίων της θερμοκρασίας, της ατμοσφαιρικής πίεσης, του ανέμου και της βροχόπτωσης σε σχέση με τα αντίστοιχα πλεγματικά πεδία ανάλυσης. Για τον συγκεκριμένο σκοπό αναπτύχθηκαν κώδικες σε Scripting Languages για την επαναπροβολή των προγνώσεων στις θέσεις των αναλύσεων καθώς και για τις εκτιμήσεις των στατιστικών μεγεθών.

**Στον πίνακα παραδοτέων φαίνονται τα 2 παραδοτέα του Έργου με τα αντίστοιχα URLs στο repository.**

**Πίνακας παραδοτέων**

| **Παραδοτέα**           | **URLs**  |
|:-------------:| -----:|
| 1. Οι κώδικες που αναπτύχθηκαν και τροποποιήθηκαν στο πλαίσιο βελτίωσης της επιχειρησιακής λειτουργίας του μοντέλου | https://github.com/ellak-monades-aristeias/Meteoclima-Seasonal-Forecast/tree/master/PART1, https://github.com/ellak-monades-aristeias/Meteoclima-Seasonal-Forecast/wiki |
| 2. Οι κώδικες αξιολόγησης των εποχιακών προγνώσεων. Διατίθενται επίσης ελεύθερα οι τρέχουσες εποχιακές προγνώσεις υπό μορφή θεματικών χαρτών και δεδομένων δυαδικής μορφής     | https://github.com/ellak-monades-aristeias/Meteoclima-Seasonal-Forecast/tree/master/PART2, https://github.com/ellak-monades-aristeias/Meteoclima-Seasonal-Forecast/wiki|


**Πληροφορίες για τα παραδοτέα, αναλυτικές τεχνικές λεπτομέρειες για τη χρήση των Scripts, η τεκμηρίωση για τον τρόπο υλοποίησης των δύο παραδοτέων του Έργου και τα βασικά συμπεράσματα υπάρχουν στο [Wiki](https://github.com/ellak-monades-aristeias/Meteoclima-Seasonal-Forecast/wiki).**

**Αναλυτικές οδηγίες που απευθύνονται σε τελικούς μη εξειδικευμένους χρήστες υπάρχουν στο [README_common.md](https://github.com/ellak-monades-aristeias/Meteoclima-Seasonal-Forecast/blob/master/README_common.md). Τεχνικές οδηγίες που απευθύνονται σε πιο εξειδικευμένους χρήστες (developers ή/και σχεδιαστές) υπάρχουν στο [README_special.md](https://github.com/ellak-monades-aristeias/Meteoclima-Seasonal-Forecast/blob/master/README_special.md)**

**Επιπλέον, το σύστημα εποχιακής πρόγνωσης πρόκειται τους επόμενους μήνες να στηθεί στον υπερυπολογιστή "ARIS" της ΕΔΕΤ, καθώς εγκρίθηκε η πρόταση που είχε κατατεθεί από την ομάδα ACDG/HUA (πρόταση "SWF"), έπειτα από την πρόσκληση  "ΕΡΓΑ ΠΡΟΕΤΟΙΜΑΣΙΑΣ / ΑΝΑΠΤΥΞΗΣ ΣΤΟ ΣΥΣΤΗΜΑ ARIS (1st Evaluation Cut-off)"**

<a rel="license" href="http://creativecommons.org/licenses/by-sa/4.0/"><img alt="Άδεια Creative Commons" style="border-width:0" src="https://i.creativecommons.org/l/by-sa/4.0/88x31.png" /></a><br />Το έργο με τίτλο <span xmlns:dct="http://purl.org/dc/terms/" property="dct:title">Πληροφορικές βελτιώσεις στην εποχιακή πρόγνωση του καιρού</span> από τον δημιουργό<a xmlns:cc="http://creativecommons.org/ns#" href="http://meteoclima.hua.gr/" property="cc:attributionName" rel="cc:attributionURL"> Γεώργιο Βάρλα</a> διατίθεται με την άδεια <a rel="license" href="http://creativecommons.org/licenses/by-sa/4.0/">Creative Commons Αναφορά Δημιουργού - Παρόμοια Διανομή 4.0 Διεθνές </a>.
