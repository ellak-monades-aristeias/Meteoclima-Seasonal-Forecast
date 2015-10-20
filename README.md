# Meteoclima-Seasonal-Forecast
**Tίτλος έργου: "Πληροφορικές βελτιώσεις στην εποχιακή πρόγνωση του καιρού"**

Η πρόγνωση καιρού βασίζεται στη χρήση αριθμητικών (μαθηματικών) μοντέλων και απαιτεί ακριβή προσομοίωση των επικρατούντων ατμοσφαιρικών φαινομένων. Κάθε αριθμητικό μοντέλο αποτελείται από ένα σύνολο εξισώσεων (θεμελιωδών εξισώσεων) οι οποίες χρησιμοποιούνται για να προβλέψουν τις μελλοντικές καταστάσεις μέσα στην ατμόσφαιρα. Η σύγχρονη αριθμητική πρόγνωση  απαιτεί γνώσεις προγραμματισμού υψηλού επιπέδου τόσο για τη χρήση και την εξέλιξη ενός ατμοσφαιρικού μοντέλου (π.χ. χρήση και επεξεργασία κωδίκων σε γλώσσα FORTRAN), όσο και για την επεξεργασία των αποτελεσμάτων της προσομοίωσης (χρήση εξειδικευμένου λογισμικού για ανάλυση και οπτικοποίηση την αποτελεσμάτων).

Η εξέλιξη της υπολογιστικής ισχύος και των πολυεπεξεργαστικών συστημάτων επιτρέπει την υλοποίηση μεσοπρόθεσμων και εποχιακών προσομοιώσεων. Οι εποχιακές προγνώσεις καιρού παρέχουν πληροφορίες για το κατά πόσο μέσες μελλοντικές καιρικές συνθήκες μπορούν πράγματι να συμβούν σε ένα χρονικό εύρος από μερικούς μήνες μέχρι ένα έτος. Οι συγκεκριμένες προγνώσεις είναι εξαιρετικά απαιτητικές σε υπολογιστική ισχύ και συνεπώς πραγματοποιούνται σχεδόν αποκλειστικά από μεγάλα διεθνή επιχειρησιακά κέντρα πρόγνωσης καιρού και κλίματος (ECMWF, NCEP, NOAA). Η εποχιακή πρόγνωση καιρού είναι ιδιαίτερα χρήσιμη για τον πολιτικό σχεδιασμό διαχείρισης της ενέργειας, των υδάτινων αποθεμάτων, της υγείας, του τουρισμού κτλ., μέσω της παροχής έγκαιρων προειδοποιήσεων για επερχόμενα και ακραία καιρικά φαινόμενα. Η μεθοδολογία βασίζεται στην εφαρμογή πιθανολογικών προσομοιώσεων (ensemble simulations), οι οποίες προσεγγίζουν την πρόγνωση στοχαστικά παρά ντετερμινιστικά.

Η Ομάδα Δυναμικής της Ατμόσφαιρας και του Κλίματος (ΟΔΑΚ ή ACDG) του Τμήματος Γεωγραφίας, της Σχολής Περιβάλλοντος, Γεωγραφίας και Εφαρμοσμένων Οικονομικών, του Χαροκόπειου Πανεπιστημίου Αθηνών (ΧΠΑ ή HUA) παρέχει ελεύθερα από το Νοέμβριο του 2014 εποχιακές προγνώσεις καιρού, οι οποίες βασίζονται σε διαδοχικές ολοκληρώσεις του αριθμητικού μοντέλου [WRF-GLOBAL ή GWRF](http://www2.mmm.ucar.edu/wrf/users/) (Skamarock et al., 2008; Zhang et al., 2012). Το συγκεκριμένο προγνωστικό προϊόν αναφέρεται στην ευρύτερη περιοχή της Ευρώπης και προσφέρεται με τη μορφή θεματικών χαρτών. Η πρόσβαση του κοινού στην πληροφορία γίνεται ελεύθερα μέσω της ιστοσελίδας **http://meteoclima.gr**. Οι εποχιακές προγνώσεις προέρχονται από πιθανολογικές προσομοιώσεις, οι οποίες περιλαμβάνουν 15 μέλη με παγκόσμια κάλυψη σε ανάλυση 1.4deg x 1.4deg και προγνωστικό εύρος ένα έτος.

Shamarock W., Klemp J. B., Dudhia J., Gill D. O., Barker D. M., Duda M., Huang X.-Y., Wang W. and Powers, J. G. (2008). A description of the advanced research WRF version 3. NCAR technical note NCAR/TN/u2013475.

Zhang Y., Hemperly J., Meskhidze N. and Skamarock W. C. (2012). The Global Weather Research and Forecasting (GWRF) Model: Model Evaluation, Sensitivity Study, and Future Year Simulation.  Atmospheric and Climate Sciences, Vol. 2 No. 3, pp. 231-253.


**Σκοπός του έργου** είναι η εξέλιξη και βελτιστοποίηση της παραλληλίας του αριθμητικού μοντέλου WRF-GLOBAL (ανοιχτοί κώδικες FORTRAN). Θα αναπτυχθούν επίσης κώδικες σε scripting languages (Linux Shell και [NCL](http://www.ncl.ucar.edu/)), για την στατιστική ανάλυση βασικών μετεωρολογικών παραμέτρων και για την παροχή γραφικών σχετικά με τις θερμοκρασιακές ανωμαλίες με βάση μέσες μηνιαίες κλιματολογικές τιμές, με διαγράμματα τύπου spaghetti, τη χωρική απεικόνιση της πιθανότητας εμφάνισης μηνιαίας βροχόπτωσης που υπερβαίνει προκαθορισμένα όρια, καθώς επίσης και τις επισημάνσεις ακραίων καιρικών φαινομένων.

**To έργο χωρίζεται σε 2 φάσεις:**

**Φάση 1: Βελτιστοποίηση επιχειρησιακής λειτουργίας**

Βελτιστοποίηση παραλληλοποίησης σε Message Passing Interface (MPI) ανοιχτών κωδίκων FORTRAN με σκοπό την αποδοτικότερη εκτέλεση του μοντέλου WRF-GLOBAL. Η βελτιστοποίηση της επιχειρησιακής λειτουργίας περιλαμβάνει εκτεταμένες τροποποιήσεις σε scripting languages (Linux Shell scripts, NCL scripts) με σκοπό τον καλύτερο συγχρονισμό των διεργασιών εκτέλεσης του μοντέλου και τη διαχείριση μεγάλου όγκου δεδομένων (big data) ως αποτελέσμα των προσομοιώσεων.

**Παραδοτέο 1: Οι κώδικες που θα αναπτυχθούν και θα τροποποιηθούν στο πλαίσιο βελτίωσης της επιχειρησιακής λειτουργίας του μοντέλου.**

**Φάση 2: Αξιολόγηση αποτελεσμάτων**

Στη συγκεκριμένη φάση θα αναπτυχθεί μεθοδολογία και λογισμικό αξιολόγησης των προγνώσεων. Η αξιολόγηση θα βασίζεται σε καθιερωμένους στατιστικούς ελέγχους των προγνωστικών πεδίων της θερμοκρασίας, της ατμοσφαιρικής πίεσης, του ανέμου και της βροχόπτωσης σε σχέση με τα αντίστοιχα πλεγματικά πεδία ανάλυσης. Για τον συγκεκριμένο σκοπό θα αναπτυχθούν κώδικες σε Scripting Languages για την επαναπροβολή των προγνώσεων στις θέσεις των αναλύσεων καθώς και για τις εκτιμήσεις των στατιστικών μεγεθών.

**Παραδοτέο 2: Οι κώδικες αξιολόγησης των εποχιακών προγνώσεων. Θα διατεθούν επίσης ελεύθερα οι τρέχουσες εποχιακές προγνώσεις υπό μορφή θεματικών χαρτών και δεδομένων δυαδικής μορφής.**

**Χρονοδιάγραμμα**      
Φάση 1:                 1η – 9η εβδομάδα       
Φάση 2:                 6η – 12η εβδομάδα 

**Οι κώδικες Linux Shell και NCL για τα παραδοτέα 1 και 2 βρίσκονται στα directories PART1 και PART2 αντίστοιχα. Πληροφορίες για τα παραδοτέα, αναλυτικές τεχνικές λεπτομέρειες για τη χρήση των Scripts, η τεκμηρίωση για τον τρόπο υλοποίησης των δύο παραδοτέων του Έργου και τα βασικά συμπεράσματα υπάρχουν στο [Wiki](https://github.com/ellak-monades-aristeias/Meteoclima-Seasonal-Forecast/wiki).**

**Αναλυτικές οδηγίες που απευθύνονται σε τελικούς μη εξειδικευμένους χρήστες υπάρχουν στο [README_common.md](https://github.com/ellak-monades-aristeias/Meteoclima-Seasonal-Forecast/blob/master/README_common.md). Τεχνικές οδηγίες που απευθύνονται σε πιο εξειδικευμένους χρήστες (developers ή/και σχεδιαστές) υπάρχουν στο [README_special.md](https://github.com/ellak-monades-aristeias/Meteoclima-Seasonal-Forecast/blob/master/README_special.md)**


<a rel="license" href="http://creativecommons.org/licenses/by-sa/4.0/"><img alt="Άδεια Creative Commons" style="border-width:0" src="https://i.creativecommons.org/l/by-sa/4.0/88x31.png" /></a><br />Το έργο με τίτλο <span xmlns:dct="http://purl.org/dc/terms/" property="dct:title">Πληροφορικές βελτιώσεις στην εποχιακή πρόγνωση του καιρού</span> από τον δημιουργό<a xmlns:cc="http://creativecommons.org/ns#" href="http://meteoclima.hua.gr/" property="cc:attributionName" rel="cc:attributionURL"> Γεώργιο Βάρλα</a> διατίθεται με την άδεια <a rel="license" href="http://creativecommons.org/licenses/by-sa/4.0/">Creative Commons Αναφορά Δημιουργού - Παρόμοια Διανομή 4.0 Διεθνές </a>.
