# Table of Contents
- [Team](#team)
- [Introduction](#introduction)
- [Requirements](#requirements)
- [Design](#design)
- [Implementation](#implementation)
- [Evaluation](#evaluation)
    - [Qualitative Evaluation](#qualitative-evaluation)
    - [Quantitative Evaluation](#quantitative-evaluation)
    - [Testing](#testing)
- [Process](#process)
- [Conclusion](#concludion)
- [Documentation of Code](#documentation-of-code)
- [Individual Contributions](#individual-contributions)

# Team

<figure>
  <img src="OrganisationFiles/GroupPhotos/IMG_3797.jpg" alt="Group photo." class="center">
  <figcaption>Group photo.</figcaption>
</figure>

<table align="center">
    <thread>
        <tr>
            <th style="text-aligh:centre">Name</th>
            <th style="text-aligh:centre">Email</th>
            <th style="text-aligh:centre">GitHub Name</th>
        </tr>
    </thread>
    <tbody>
        <tr>
            <th style="text-aligh:centre">Yiding Chen</th>
            <th style="text-aligh:centre">vf23652@bristol.ac.uk</th>
            <th style="text-aligh:centre">Ch1eti</th>
        </tr>
        <tr>
            <th style="text-aligh:centre">Kelvin Lu</th>
            <th style="text-aligh:centre">rl17487@bristol.ac.uk</th>
            <th style="text-aligh:centre">LurchK</th>
        </tr>
        <tr>
            <th style="text-aligh:centre">Ziang Zhang</th>
            <th style="text-aligh:centre">ma23462@bristol.ac.uk</th>
            <th style="text-aligh:centre">Zazhang3</th>
        </tr>
        <tr>
            <th style="text-aligh:centre">Klaudia Żymełka</th>
            <th style="text-aligh:centre">ex23530@bristol.ac.uk</th>
            <th style="text-aligh:centre">klaudz9</th>
        </tr>
    </tbody>
</table>

# Introduction

Our project is based on the famous 2010s game, Angry Birds. In the original game, the player would shoot birds with the slingshot to kill pigs which were protected by different structures. In our version called Anxious Pigs players act as protectors, taking the quest from the Pig King to help the pigs survive the attacks.   

Players have a budget that they can spend on buying basic materials like glass, wood and stone. Those materials can be used to build strong structures shielding pigs from upcoming attacks. Cheaper structures are less resilient but if used creatively they can be game-changing.   

Attacks come in three waves and are conducted by three types of birds with different abilities. Red birds don’t have any superpowers. Purple birds can reverse gravity upon the first object they collide with. Black birds can explode, destroying the players’ carefully built structures in an instant!   

Find out why pigs became so anxious, discover the most efficient ways to protect pigs, compare your score to other players included in the ‘Best Pig Protector’ ranking and become the next Pig King!   


<figure>
  <img src="OrganisationFiles/ReportGifs/IntroGif.gif" alt="Example of gameplay." class="center">
  <figcaption>Demonstration of a gameplay.</figcaption>
</figure>

All of the art included in the game was drawn by one of the members in a free software Krita (except for the background which was generated with the AI image generator DALL-E).   

As a team, we believe we successfully managed to implement the game we envisioned. Good luck protecting all the pigs and remember the Pig King counts on you! 

# Requirements

# Design

# Implementation

# Evaluation

## Qualitative Evaluation
The qualitative evaluation was conducted at three stages during the development process. With this approach, the team made design improvements before having a fully developed game.  

Think-aloud evaluation was conducted during all three stages and heuristic evaluation was conducted during stages two and three. All results can be viewed here. 

<em>Stage 1</em> - Conducted before the game was playable: 
<ol>
    <li>Start a game and enter your name.</li>
    <li>Complete the tutorial.</li>
    <li>From the game screen check the scoreboard.</li>
</ol>
The following issues were identified: 
<ul>
  <li>The tutorial structure was confusing, users would close the tutorial without reading it.</li>
  <li>The tutorial was poorly noticeable on the background </li>
  <figure>
  <img src="OrganisationFiles\ImplementedChangesImages\ImageSolution1.png" alt="Tutorial evolution." class="center">
  <figcaption>Evolution of the tutorial.</figcaption>
</figure>
  <li>Lack of upper case letters during name-entering </li>
  <figure>
  <img src="OrganisationFiles\EvaluationsDataImplementedChangesImages\ImageSolution2.png" alt="Upper case letters were added." class="center">
  <figcaption>Upper case letters were added.</figcaption>
</figure>
</ul>



## Quantitative Evaluation
The team decided to use the System Usability Scale (SUS) to evaluate the game's interface design. We did not distinguish between the difficulty levels as their designs were very similar. Users were asked to fill out the questionnaire after playing both difficulty levels. The achieved results are presented below:

<figure>
  <img src="OrganisationFiles\EvaluationsData/SUS_evaluation_result_table.png" alt="Table with results from the SUS evaluation." class="center">
  <figcaption>Table with results from the SUS evaluation.</figcaption>
</figure>

Overall achieved score was above the average of 68 suggesting that our system was easy to use and understandable. We believe such a high score was achieved because of the qualitative evaluation being conducted in the early development stages.  

In the raw NASA TLX evaluation, the users were asked to fill in the provided form after completing the game on easy mode and once more after the hard mode. Achieved scores are presented below.


<figure>
  <img src="OrganisationFiles\EvaluationsData/NASATLX_evaluation_result_EASY_table.png" alt="Table with raw NASA TLX results from Easy mode." class="center">
  <figcaption>Table with raw NASA TLX results from Easy mode.</figcaption>
</figure>


<figure>
  <img src="OrganisationFiles\EvaluationsData/NASATLX_evaluation_result_HARD_table.png" alt="Table with raw NASA TLX results from Hard mode." class="center">
  <figcaption>Table with raw NASA TLX results from Hard mode.</figcaption>
</figure>


<figure>
  <img src="OrganisationFiles\EvaluationsData/NASATLX_evaluation_result_graph.png" alt="Raw NASA TLX results in a graph form." class="center">
  <figcaption>Raw NASA TLX results in a graph form.</figcaption>
</figure>
 
The results indicated that the hard mode demanded more workload which matches the design intention. However, it is worth pointing out that 3 out of 10 users perceived the easy mode as the harder one. This could have been caused by the fact that the users gained experience while playing the easy mode and thus they possessed more skills while playing the hard mode. Wilcoxon Signed Rank Test was conducted and according to the following <a href="https://www.statology.org/wilcoxon-signed-rank-test-calculator/">website</a>: 

W test statistic = 8 

Number of non-tied pairs (n) = 10 

According to the table found on the same website, the alpha value equals 0.1 which suggested that in future game versions, the difference in difficulty levels should be increased as the team's aim was to achieve the alpha value of 0.05. 

## Testing

The physics engine was developed separately from the game code. To make sure that all collisions were working properly, birds, pigs and squares were created on a screen and collided with each other in all possible scenarios.  

The scoreboard was tested by checking the top players each time after the game was played. 

During the process of developing different levels, special 'cheat keys' were defined to easily test levels two and three. This was very useful when testing different birds' abilities and attack directions as well as the displays of budget, level and amount of birds preparing for the attack on a given level. 

Additionally, every new feature was developed on a separate branch and tested by all team members separately thinking about edge cases before being merged with the main.

# Process

# Conclusion

# Documentation of Code

# Individual Contributions

<table align="center">
    <thread>
        <tr>
            <th style="text-aligh:centre">Member</th>
            <th style="text-aligh:centre">Score</th>
            <th style="text-aligh:centre">Contribution</th>
        </tr>
    </thread>
    <tbody>
        <tr>
            <th style="text-aligh:centre">Yiding Chen</th>
            <th style="text-aligh:centre">1</th>
            <th style="text-aligh:centre"></th>
        </tr>
        <tr>
            <th style="text-aligh:centre">Kelvin Lu</th>
            <th style="text-aligh:centre">1</th>
            <th style="text-aligh:centre"></th>
        </tr>
        <tr>
            <th style="text-aligh:centre">Ziang Zhang</th>
            <th style="text-aligh:centre">1</th>
            <th style="text-aligh:centre"></th>
        </tr>
        <tr>
            <th style="text-aligh:centre">Klaudia Żymełka</th>
            <th style="text-aligh:centre">1</th>
            <th style="text-aligh:centre"></th>
        </tr>
    </tbody>
</table>