- Bar Chart
- Histogram
- Box Plot
- Density Plots

### Bar plots

```Python
monthly_sales = {"data" : [{'type': 'bar', 
							'x': ['Jan', 'Feb', 'March'], 
							'y': [450, 475, 400]}],
				"layout": {'title': {'text': 'Sales for Jan-Mar 2020'}}
fig = go.Figure(monthly_sales)
fig.show()
```

Con ``plotly express`` :

```Python
import plotly express as px
fig = px.bar(data_frame=weekly_temps, x="day", y="temp")
```



#### Ejemplo: Student scores bar graph

The school board has asked you to come and look at some test scores. They want an easy way to visualize the score of different students within a small class. This seems like a simple use case to practice your bar chart skills!

In this exercise, you will help the school board team by creating a bar chart of school test score values.

A DataFrame `student_scores` has been provided. In this and all future exercises where it is needed, `plotly.express` has already been loaded as `px`

```Python
# Create the bar plot
fig = px.bar(data_frame=student_scores, 
             x="student_name", 
             y="score", 
             title="Student Scores by Student")
# Show the plot
fig.show()
```
